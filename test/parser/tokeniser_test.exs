defmodule Parser.RulesTest do
  use ExUnit.Case

  for {tc, input, result} <- [
    {"wildcard", "*", {Parser.RuleTypes.wildcard}},
    {"range", "1-5", {Parser.RuleTypes.range, 1, 5}}
  ] do
    @description tc
    @expected input
    @actual result

    test "Can handle #{@description} with input #{@expected}" do
      assert Parser.Tokeniser.run("#{@expected}") == @actual
    end
  end

  test "It raises an error if the input is incorrect" do
    assert_raise(
      ArgumentError,
      "Incorrect argument passed. Must be a valid operator with applicable terms",
      fn ->
        Parser.Tokeniser.run("wwww")
      end
    )
  end
end
