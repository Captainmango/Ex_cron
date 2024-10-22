defmodule Parser.Rules do
  @spec evaluate_rule(nonempty_binary()) :: :range | :wildcard
  def evaluate_rule(<<_::binary-size(1), "-", _::binary>>) do
    Common.RulesTypes.range
  end

  def evaluate_rule(<<"*">>) do
    Common.RulesTypes.wildcard
  end

  def evaluate_rule(_) do
    raise ArgumentError.exception("Incorrect argument passed. Must be a valid operator with applicable terms")
  end
end
