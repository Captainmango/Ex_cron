defmodule CronParser.Printer do
  def print(out \\ :stdio, content) do
    IO.write(out, content)
  end
end
