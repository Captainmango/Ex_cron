defmodule Parser.RulesTest do
  use ExUnit.Case

  test "It can parse a wild card argument" do
    assert Parser.Rules.evaluate_rule("*") == Common.RulesTypes.wildcard
  end

  test "It can parse a range argument" do
    assert Parser.Rules.evaluate_rule("1-5") == Common.RulesTypes.range
  end

  test "It can parse a div mod argument" do
    assert Parser.Rules.evaluate_rule("*/5") == Common.RulesTypes.divisor
  end

  test "It can parse a singular number argument" do
    assert Parser.Rules.evaluate_rule("1") == Common.RulesTypes.single_num
  end

  test "It can parse a list argument" do
    assert Parser.Rules.evaluate_rule("1,5") == Common.RulesTypes.list
  end

  test "It raises an error if the input is incorrect" do
    assert_raise(
      ArgumentError,
      "Incorrect argument passed. Must be a valid operator with applicable terms",
      Parser.Rules.evaluate_rule("wwww")
    )
  end
end
