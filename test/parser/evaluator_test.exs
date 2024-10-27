defmodule Parser.EvaluatorTest do
  use ExUnit.Case, async: true

  test "it runs correctly for wildcard" do
    res = Parser.Evaluator.run({:wildcard}, :day_of_week)

    assert res == Enum.to_list(1..7)
  end

  test "it runs correctly for range" do
    res = Parser.Evaluator.run({:range, 1, 4}, :day_of_week)

    assert res == Enum.to_list(1..4)
  end

  test "it runs correctly for list" do
    res = Parser.Evaluator.run({:list, 1, 4}, :day_of_week)

    assert res == [1, 4]
  end

  test "it runs correctly for divisor" do
    res = Parser.Evaluator.run({:divisor, 2}, :day_of_week)

    assert res == [2, 4, 6]
  end

  test "it runs correctly for single num" do
    res = Parser.Evaluator.run({:single_num, 2}, :day_of_week)

    assert res == [2]
  end
end
