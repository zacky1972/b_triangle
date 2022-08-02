defmodule BTriangleTest do
  use ExUnit.Case
  doctest BTriangle

  test "read_graph input1" do
    assert BTriangle.read_graph(File.read!("test/support/input1.txt")) ==
             %{
               1 => %{4 => 4, 5 => 5},
               2 => %{3 => 3, 5 => 5},
               3 => %{2 => 2, 5 => 5},
               4 => %{1 => 1, 5 => 5},
               5 => %{1 => 1, 2 => 2, 3 => 3, 4 => 4}
             }
  end

  test "read_graph input2" do
    assert BTriangle.read_graph(File.read!("test/support/input2.txt")) ==
             %{1 => %{2 => 2}, 2 => %{1 => 1}, 3 => %{}}
  end

  test "read_graph input3" do
    assert BTriangle.read_graph(File.read!("test/support/input3.txt")) ==
             %{
               1 => %{3 => 3, 5 => 5, 6 => 6, 7 => 7},
               2 => %{4 => 4, 5 => 5, 7 => 7},
               3 => %{1 => 1, 6 => 6},
               4 => %{2 => 2, 7 => 7},
               5 => %{1 => 1, 2 => 2, 7 => 7},
               6 => %{1 => 1, 3 => 3},
               7 => %{1 => 1, 2 => 2, 4 => 4, 5 => 5}
             }
  end
end
