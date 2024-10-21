defmodule Parser.RulesTest do
  use ExUnit.Case

  test "It can parse a wild card argument" do
    assert Parser.Rules.evaluate("*") == Common.RulesTypes.wildcard
  end

  test "It can parse a range argument" do
    assert Parser.Rules.evaluate("1-5") == Common.RulesTypes.range
  end

  test "It can parse a div mod argument" do
    assert Parser.Rules.evaluate("*/5") == Common.RulesTypes.divisor
  end

  test "It can parse a singular number argument" do
    assert Parser.Rules.evaluate("1") == Common.RulesTypes.single_num
  end

  test "It can parse a list argument" do
    assert Parser.Rules.evaluate("1,5") == Common.RulesTypes.list
  end
end
