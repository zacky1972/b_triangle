defmodule BTriangle do
  @moduledoc """
  Elixir code for B Triangle of AtCoder Beginner Contest 262.
  """

  @type graph() :: %{pos_integer() => %{pos_integer() => pos_integer()}}

  def main do
    IO.read(:stdio, :eof)
    |> read_graph()
    |> solve2()
    |> IO.puts()
  end

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
  def graph_add(map, u, v) when u < v do
    map
    |> Map.put(u, Map.get(map, u) |> Map.put(v, v))
  end

  def graph_add(map, u, v) when u > v do
    graph_add(map, v, u)
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

  @spec solve2({pos_integer(), graph()}) :: non_neg_integer()
  def solve2({n, graph}) do
    for a <- 1..(n - 2), b <- (a + 1)..(n - 1) do
      {a, b}
    end
    |> Enum.filter(fn {a, b} -> graph_match?(graph, a, b) end)
    |> Enum.map(fn {a, b} ->
      for c <- (b + 1)..n do
        {a, b, c}
      end
    end)
    |> List.flatten()
    |> Enum.filter(fn {a, b, c} ->
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
