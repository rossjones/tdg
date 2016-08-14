defmodule TDG.GeneratorController do
  use TDG.Web, :controller
  alias TDG.Generator
  alias Poison, as: JSON

  def generate(conn, %{"instructions"=>instructions}=params) do
    instr = JSON.decode!(instructions)
    processors = get_processors(instr)

    {:ok, c} = conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("Content-Disposition", "attachment; filename=\"generated.csv\"")
    |> send_chunked(200)
    |> chunk(get_headers(processors))

    for r <- 1..Map.get(instr, "rows") do
      { :ok, c } = chunk(c, "\r\n")

      row = processors
        |> Enum.map( fn {_, proc} ->
          encode(proc.())
        end)
        |> Enum.join(",")

      { :ok, c } = chunk(c, row)
    end

    c
  end

  defp get_headers(processors) do
    processors
    |> Enum.map(fn {col, _} ->
      encode(col)
    end)
    |> Enum.join(",")
  end

  defp get_processors(instr) do
    Map.get(instr, "columns")
    |> Enum.map(fn c ->
        {
          Map.get(c, "name"),
          get_generator(Map.get(c, "type"), Map.get(c, "args"))
        }
    end)
  end

  defp encode(s) do
    resp = s
    |> String.replace("\"", "\"\"")
    ~s("#{resp}")
  end

  defp get_generator("integer", args) do
    TDG.Generator.Integers.generate(args)
  end
  defp get_generator("float", args) do
    TDG.Generator.Floats.generate(args)
  end
  defp get_generator("words", args) do
    TDG.Generator.Words.generate(args)
  end

end
