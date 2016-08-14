defmodule TDG.Generator.Integers do

  def generate(args) do
    mini = Map.get(args, "min")
    maxi = Map.get(args, "max")
    fn -> calc(mini, maxi) end
  end

  def calc(min, max) do
    :random.seed(:erlang.now)
    to_string :random.uniform(max) + min
  end

end