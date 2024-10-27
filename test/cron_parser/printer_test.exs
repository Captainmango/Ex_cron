defmodule PrinterTest do
  use ExUnit.Case, async: true

  alias CronParser.Parser.Tokeniser, as: Tokeniser
  alias CronParser.Parser.Evaluator, as: Evaluator
  alias CronParser.Printer, as: Printer

  test "it can write data" do
    cf = Tokeniser.run("1,5")
    line_to_write = Evaluator.run(cf, :hours)

    {:ok, fake_file_pid} = StringIO.open("fake file")
    Printer.print(fake_file_pid, line_to_write)

    {_, o} = StringIO.contents(fake_file_pid)
    assert o == <<1, 5>>
  end
end
