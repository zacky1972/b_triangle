defmodule BTriangleTest do
  use ExUnit.Case
  doctest BTriangle

  test "read_graph input1" do
    assert BTriangle.read_graph(File.read!("test/support/input1.txt")) ==
             {
               5,
               %{
                 1 => %{4 => 4, 5 => 5},
                 2 => %{3 => 3, 5 => 5},
                 3 => %{5 => 5},
                 4 => %{5 => 5},
                 5 => %{}
               }
             }
  end

  test "read_graph input2" do
    assert BTriangle.read_graph(File.read!("test/support/input2.txt")) ==
             {3, %{1 => %{2 => 2}, 2 => %{}, 3 => %{}}}
  end

  test "read_graph input3" do
    assert BTriangle.read_graph(File.read!("test/support/input3.txt")) ==
             {7,
              %{
                1 => %{3 => 3, 5 => 5, 6 => 6, 7 => 7},
                2 => %{4 => 4, 5 => 5, 7 => 7},
                3 => %{6 => 6},
                4 => %{7 => 7},
                5 => %{7 => 7},
                6 => %{},
                7 => %{}
              }}
  end

  test "solve input1" do
    assert File.read!("test/support/input1.txt") |> BTriangle.read_graph() |> BTriangle.solve() ==
             2
  end

  test "solve input2" do
    assert File.read!("test/support/input2.txt") |> BTriangle.read_graph() |> BTriangle.solve() ==
             0
  end

  test "solve input3" do
    assert File.read!("test/support/input3.txt") |> BTriangle.read_graph() |> BTriangle.solve() ==
             4
  end

  test "solve2 input1" do
    assert File.read!("test/support/input1.txt") |> BTriangle.read_graph() |> BTriangle.solve2() ==
             2
  end

  test "solve2 input2" do
    assert File.read!("test/support/input2.txt") |> BTriangle.read_graph() |> BTriangle.solve2() ==
             0
  end

  test "solve2 input3" do
    assert File.read!("test/support/input3.txt") |> BTriangle.read_graph() |> BTriangle.solve2() ==
             4
  end

  test "solve_task input1" do
    assert File.read!("test/support/input1.txt") |> BTriangle.read_graph() |> BTriangle.solve_task() ==
             2
  end
end
