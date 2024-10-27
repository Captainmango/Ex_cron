defmodule Parser.TokeniserTest do
  use ExUnit.Case, async: true

  alias CronParser.Parser.RuleTypes, as: RuleTypes
  alias CronParser.Parser.Tokeniser, as: Tokeniser
  alias CronParser.Parser.Errors, as: Errors

  for {tc, input, result} <- [
        {"wildcard", "*", {RuleTypes.wildcard()}},
        {"range", "1-5", {RuleTypes.range(), 1, 5}},
        {"range two digits", "10-5", {RuleTypes.range(), 10, 5}},
        {"range two digits", "10-55", {RuleTypes.range(), 10, 55}},
        {"divisor", "*/5", {RuleTypes.divisor(), 5}},
        {"divisor two digits", "*/15", {RuleTypes.divisor(), 15}},
        {"list", "1,5", {RuleTypes.list(), 1, 5}},
        {"list two digits", "10,5", {RuleTypes.list(), 10, 5}},
        {"single", "1", {RuleTypes.single_num(), 1}},
        {"single tow digits", "15", {RuleTypes.single_num(), 15}},
      ] do
    @description tc
    @expected input
    @actual result

    test "Returns #{@description} rule with input #{@expected}" do
      assert Tokeniser.run("#{@expected}") == @actual
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
        Errors.TokeniseError,
        "Incorrect argument passed. Must be a valid operator with applicable terms",
        fn ->
          Tokeniser.run(@input)
        end
      )
    end
  end
end
