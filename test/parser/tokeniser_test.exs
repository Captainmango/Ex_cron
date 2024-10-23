defmodule Parser.RulesTest do
  use ExUnit.Case

  test "It can parse wildcard" do
    assert Parser.Tokeniser.run("*") == {Parser.RuleTypes.wildcard}
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
