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

  @spec graph_match?(graph(), pos_integer(), pos_integer()) :: boolean()
  def graph_match?(graph, u, v) when u < v do
    case graph |> Map.get(u) |> Map.get(v) do
      nil -> false
      _ -> true
    end
  end

  def graph_match?(graph, u, v) when u > v do
    graph_match?(graph, v, u)
  end

  @spec solve({pos_integer(), graph()}) :: non_neg_integer()
  def solve({n, graph}) do
    for a <- 1..(n - 2), b <- (a + 1)..(n - 1), c <- (b + 1)..n do
      {a, b, c}
    end
    |> Enum.filter(fn {a, b, c} ->
      graph_match?(graph, a, b) and
        graph_match?(graph, b, c) and
        graph_match?(graph, a, c)
    end)
    |> Enum.count()
  end

  @spec solve_task({pos_integer(), graph()}) :: non_neg_integer()
  def solve_task({n, graph}) do
    for a <- 1..(n - 2), b <- (a + 1)..(n - 1), c <- (b + 1)..n do
      {a, b, c}
    end
    |> Enum.chunk_every(10_000)
    |> Enum.map(&
      Task.async(fn ->
        Enum.filter(&1, fn {a, b, c} ->
          graph_match?(graph, a, b) and
          graph_match?(graph, b, c) and
          graph_match?(graph, a, c)
        end)
      end)
    )
    |> Enum.map(&Task.await/1)
    |> List.flatten()
    |> Enum.count()
  end
end
