defmodule CronParser.ExCron do
  def main(args \\ []) do
    {_, input, errors} = OptionParser.parse(args, [strict: []])

    if [] != errors, do: IO.puts(inspect(errors))

    IO.puts(inspect(input))
  end
end
