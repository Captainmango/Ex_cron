defmodule Parser.Evaluator do
  @type cron_fragment
    :: {:list, integer(), integer()}
    | {:single_num, integer()}
    | {:divisor, integer()}
    | {:wildcard}
    | {:range, integer(), integer()}

  @type interval
    :: :minutes
    | :hours
    | :day_of_month
    | :month
    | :day_of_week

  defguardp is_in_range(num, start, final) when num >= start and num <= final

  @spec run(cf::cron_fragment(), i::interval()) :: list()
  def run(cf, i) do
    range = Parser.Intervals.Ranges.get(i)

    start = hd(range)
    last_num = List.last(range)

    case cf do
      {:wildcard}
        -> range
      {:range, n1, n2} when is_in_range(n1, start, last_num) and is_in_range(n2, start, last_num)
        -> Enum.filter(range, &(&1 <= n2 and &1 >= n1))
      {:list, n1, n2} when is_in_range(n1, start, last_num) and is_in_range(n2, start, last_num)
        -> Enum.filter(range, &(&1 in [n1, n2]))
      {:divisor, n} when is_in_range(n, start, last_num)
        -> Enum.filter(range, &(rem(&1, n) == 0))
      {:single_num, n} when is_in_range(n, start, last_num)
        -> [n]
      _
        -> raise Parser.Errors.EvaluateError
    end
  end
end
