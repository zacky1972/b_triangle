import BTriangle

:rand.seed(:exsss, {100, 101, 102})
n = 100
m = :rand.uniform(div(n * (n - 1), 2))

graph = graph_init(n)

uv =
  for u <- 1..(n - 1), v <- (u + 1)..n do
    {u, v}
  end
  |> Enum.take_random(m)

graph = Enum.reduce(uv, graph, fn {u, v}, map -> graph_add(map, u, v) end)

Benchee.run(
  %{
    "solve #{n}, #{m}" => fn -> solve({n, graph}) end,
    "solve_task #{n}, #{m}" => fn -> solve_task({n, graph}) end
  }
)
