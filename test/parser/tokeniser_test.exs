defmodule Parser.RulesTest do
  use ExUnit.Case, async: true

  for {tc, input, result} <- [
        {"wildcard", "*", {Parser.RuleTypes.wildcard()}},
        {"range", "1-5", {Parser.RuleTypes.range(), 1, 5}},
        {"range two digits", "10-5", {Parser.RuleTypes.range(), 10, 5}},
        {"range two digits", "10-55", {Parser.RuleTypes.range(), 10, 55}},
        {"divisor", "*/5", {Parser.RuleTypes.divisor(), 5}},
        {"divisor two digits", "*/15", {Parser.RuleTypes.divisor(), 15}},
        {"list", "1,5", {Parser.RuleTypes.list(), 1, 5}},
        {"list two digits", "10,5", {Parser.RuleTypes.list(), 10, 5}}
      ] do
    @description tc
    @expected input
    @actual result

    test "Returns #{@description} rule with input #{@expected}" do
      assert Parser.Tokeniser.run("#{@expected}") == @actual
    end
  end

  for {input} <- [
        {"t"},
        {"a-b"},
        {"*/ttt"},
        {"1,f"}
      ] do
    @input input

    test "It raises an error if input is #{@input}" do
      assert_raise(
        Errors.RunError,
        "Incorrect argument passed. Must be a valid operator with applicable terms",
        fn ->
          Parser.Tokeniser.run(@input)
        end
      )
    end
  end
end
