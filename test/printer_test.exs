defmodule PrinterTest do
  use ExUnit.Case, async: true

  test "it can write data" do
    cf = Parser.Tokeniser.run("1,5")
    line_to_write = Parser.Evaluator.run(cf, :hours)

    {:ok, fake_file_pid} = StringIO.open("fake file")
    Printer.print(fake_file_pid, line_to_write)

    {_, o} = StringIO.contents(fake_file_pid)
    assert o == <<1, 5>>
  end
end
