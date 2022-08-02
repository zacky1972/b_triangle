defmodule BTriangle do
  @moduledoc """
  Documentation for `BTriangle`.
  """

  @type graph() :: %{pos_integer() => %{pos_integer() => pos_integer()}}

  @spec read_graph(String.t()) :: {pos_integer(), graph()}
  def read_graph(str) do
    line =
      str
      |> String.split("\n")
      |> Enum.reject(&(&1 == ""))

    [nm | uv] = line

    [n, m] =
      nm
      |> String.split(" ")
      |> Enum.map(&String.to_integer/1)

    uv =
      Enum.take(uv, m)
      |> Enum.map(
        &(&1
          |> String.split(" ")
          |> Enum.map(fn x -> String.to_integer(x) end)
          |> List.to_tuple())
      )

    {n, Enum.reduce(uv, graph_init(n), fn {u, v}, map -> graph_add(map, u, v) end)}
  end

  @spec graph_init(pos_integer()) :: graph()
  def graph_init(n) do
    1..n
    |> Enum.map(fn _ -> %{} end)
    |> Enum.with_index()
    |> Enum.map(fn {v, k} -> {k + 1, v} end)
    |> Map.new()
  end

  @spec graph_add(graph(), pos_integer(), pos_integer()) :: graph()
  def graph_add(map, u, v) do
    map
    |> Map.put(u, Map.get(map, u) |> Map.put(v, v))
    |> Map.put(v, Map.get(map, v) |> Map.put(u, u))
  end
end
