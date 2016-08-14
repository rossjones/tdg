defmodule TDG.Generator.Floats do

  def generate(args) do
    :random.seed(:erlang.now)

    mini = Map.get(args, "min")
    maxi = Map.get(args, "max")
    places = Map.get(args, "places", 2)
    fn -> calc(mini, maxi, places) end
  end

  def calc(min, max, places) do
    [h, t] = (:random.uniform * max) + min - 1.0
      |> to_string
      |> String.split(".")

    "#{h}.#{String.slice(t, 1..places)}"
  end

end