defmodule Parser.Tokeniser do
  def run(<<"*">>) do
    {Parser.RuleTypes.wildcard}
  end

  def run(_) do
    raise ArgumentError.exception("Incorrect argument passed. Must be a valid operator with applicable terms")
  end
end
