defmodule Parser.Rules do
  def evaluate(<<_::binary-size(1), "-", _::binary>>) do
    Common.RulesTypes.range
  end

  def evaluate(<<"*">>) do
    Common.RulesTypes.wildcard
  end
end
