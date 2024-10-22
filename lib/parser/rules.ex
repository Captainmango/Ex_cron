defmodule Parser.Rules do
  def evaluate_rule(<<_::binary-size(1), "-", _::binary>>) do
    Common.RulesTypes.range
  end

  def evaluate_rule(<<"*">>) do
    Common.RulesTypes.wildcard
  end
end
