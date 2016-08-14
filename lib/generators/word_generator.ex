defmodule TDG.Generator.Words do



  def generate(args) do
    :random.seed(:erlang.now)
    words = File.read!("words.terms") |> :erlang.binary_to_term

    count = Map.get(args, "count")
    fn -> calc(count, words) end
  end

  def calc(count, words) do
    pos = :random.uniform(length(words)) - 1
    words |> Enum.slice(pos, count) |> Enum.join(" ")
  end

end