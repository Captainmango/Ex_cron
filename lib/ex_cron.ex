defmodule ExCron do
  use Application

  @children [{Plug.Cowboy, [scheme: :http, plug: TaskScheduler.Router, port: 8000]}]
  @opts [strategy: :one_for_one, supervisor: TaskScheduler.Supervisor]

  @impl true
  def start(_type, _args) do
    Supervisor.start_link(@children, @opts)
  end

  def main(args \\ []) do
    run_mode = System.get_env("MODE", "CLI")

    case run_mode do
      "WEB" -> Supervisor.start_link(@children, @opts)
      "CLI"
        -> {_, input, errors} = OptionParser.parse(args, [strict: []])

        if [] != errors, do: IO.puts(inspect(errors))

        IO.puts(inspect(input))
    end

  end
end
