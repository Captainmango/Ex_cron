defmodule Parser.EvaluatorTest do
  use ExUnit.Case, async: true

  alias CronParser.Parser.Evaluator, as: Evaluator
  alias CronParser.Parser.Errors, as: Errors
  alias CronParser.ParsedCron, as: ParsedCron

  test "it runs correctly for wildcard" do
    res = Evaluator.run({:wildcard}, :day_of_week)

    assert res == Enum.to_list(1..7)
  end

  test "it runs correctly for range" do
    res = Evaluator.run({:range, 1, 4}, :day_of_week)

    assert res == Enum.to_list(1..4)
  end

  test "it runs correctly for list" do
    res = Evaluator.run({:list, 1, 4}, :day_of_week)

    assert res == [1, 4]
  end

  test "it runs correctly for divisor" do
    res = Evaluator.run({:divisor, 2}, :day_of_week)

    assert res == [2, 4, 6]
  end

  test "it runs correctly for single num" do
    res = Evaluator.run({:single_num, 2}, :day_of_week)

    assert res == [2]
  end

  test "it errors if num outside of range" do
    assert_raise(
      Errors.EvaluateError,
      fn ->
        Evaluator.run({:single_num, 999}, :day_of_week)
      end
    )
  end

  test "it can evaluate a cron" do
    input = %CronParser.Cron{
      minutes: "1",
      hours: "1",
      day_of_month: "1",
      month: "1",
      day_of_week: "1",
    }

    res = Evaluator.run_for_cron(input)

    assert CronParser.ParsedCron.format(res) == "minutes      | 1\nhours        | 1\nday_of_month | 1\nmonth        | 1\nday_of_week  | 1\n"
  end
end
