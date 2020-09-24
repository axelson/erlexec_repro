defmodule ErlexecReproApplication do
  def start(_type, _args) do
    children = [
      {Task.Supervisor, name: ErlexecRepro.TaskSupervisor}
    ]

    Supervisor.start_link(children, strategy: :one_for_one)
  end
end
