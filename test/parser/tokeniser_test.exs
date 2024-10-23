defmodule Parser.RulesTest do
  use ExUnit.Case, async: true

  for {tc, input, result} <- [
    {"wildcard", "*", {Parser.RuleTypes.wildcard}},
    {"range", "1-5", {Parser.RuleTypes.range, 1, 5}}
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
        ArgumentError,
        "Incorrect argument passed. Must be a valid operator with applicable terms",
        fn ->
          Parser.Tokeniser.run(@input)
        end
      )
    end
  end
end
