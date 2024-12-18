defmodule CronParser.Parser.Tokeniser do
  alias CronParser.Parser.RuleTypes, as: RuleTypes
  defguardp is_correct_size(t) when is_binary(t) and byte_size(t) in [1, 2]

  @type cron_fragment
  :: {:list, integer(), integer()}
  | {:single_num, integer()}
  | {:divisor, integer()}
  | {:wildcard}
  | {:range, integer(), integer()}

  @spec run(binary()) :: cron_fragment()
  def run(<<"*">>) do
    {RuleTypes.wildcard()}
  end

  def run(<<n1::binary-size(1), "-", n2::binary>>) when is_correct_size(n2) do
    {
      RuleTypes.range(),
      handle_number_conversion(n1),
      handle_number_conversion(n2)
    }
  end

  def run(<<n1::binary-size(2), "-", n2::binary>>) when is_correct_size(n2) do
    {
      RuleTypes.range(),
      handle_number_conversion(n1),
      handle_number_conversion(n2)
    }
  end

  def run(<<"*/", n1::binary>>) when is_correct_size(n1) do
    {
      RuleTypes.divisor(),
      handle_number_conversion(n1)
    }
  end

  def run(<<n1::binary-size(1), ",", n2::binary>>) when is_correct_size(n2) do
    {
      RuleTypes.list(),
      handle_number_conversion(n1),
      handle_number_conversion(n2)
    }
  end

  def run(<<n1::binary-size(2), ",", n2::binary>>) when is_correct_size(n2) do
    {
      RuleTypes.list(),
      handle_number_conversion(n1),
      handle_number_conversion(n2)
    }
  end

  def run(<<n::binary>>) when is_correct_size(n) do
    {
      RuleTypes.single_num(),
      handle_number_conversion(n)
    }
  end

  def run(_) do
    raise CronParser.Parser.Errors.TokeniseError
  end

  defp handle_number_conversion(n) do
    try do
      String.to_integer(n)
    rescue
      e -> reraise(CronParser.Parser.Errors.TokeniseError, [exception: e], __STACKTRACE__)
    end
  end
end
