defmodule ErlexecRepro do
  @moduledoc """
  Documentation for `ErlexecRepro`.
  """

  def demo do
    root_dir = make_temp_dir!()
    :exec.run_link(executable_path(root_dir) |> to_charlist(), [
      {:cd, root_dir |> to_charlist()},
      :stdout,
      :stderr,
      :stdin,
      :monitor
    ])
  end

  def make_temp_dir! do
    id = System.unique_integer([:positive, :monotonic])
    path = Path.join(System.tmp_dir!(), "frotz-#{id}-#{random_padding()}")
    File.mkdir!(path)
    path
  end

  defp random_padding(length \\ 20) do
    :crypto.strong_rand_bytes(length)
    |> Base.url_encode64()
    |> binary_part(0, length)
    |> String.replace(~r/[[:punct:]]/, "")
  end

  defp executable_path(root_dir) do
    Enum.join(
      [
        frotz_path(),
        "-r lt -r lt",
        "-f ansi",
        "-w80 -h120",
        "-R #{root_dir}",
        story_path()
      ]
      |> List.flatten(),
      " "
    )
  end

  def story_path do
    Path.join(:code.priv_dir(:erlexec_repro), "kitten.z5")
  end

  def frotz_path do
    Path.join(:code.priv_dir(:erlexec_repro), "dfrotz")
    # "/usr/local/bin/dfrotz"
  end
end
