defmodule ErlexecReproTest do
  use ExUnit.Case
  doctest ErlexecRepro

  test "greets the world" do
    # 300 runs without error
    # 350 causes a hang on number 691
    # 400 causes a hang on number 741
    # 450 causes a hang on number 791
    # 500 starts to hang on a random number
    concurrency = 400

    Task.Supervisor.async_stream_nolink(ErlexecRepro.TaskSupervisor, 1..2000, fn number ->
      IO.inspect(number, label: "number")
      {:ok, pid, _os_pid} = ErlexecRepro.demo()
      Process.sleep(Enum.random(100..3000))
    end, ordered: false, max_concurrency: concurrency, timeout: 30_000)
    |> Enum.to_list()
    |> IO.inspect(label: "result")

    Process.sleep(5_000)
  end
end
