defmodule CronParser.Parser.Evaluator do
  alias CronParser.Parser.Intervals.Ranges, as: R
  alias CronParser.Parser.Tokeniser, as: T
  alias CronParser.{Cron, ParsedCron}
  alias CronParser.Parser.Errors, as: Errors

  defguardp is_in_range(num, start, final) when num >= start and num <= final

  @spec run(cf::T.cron_fragment(), i::R.interval()) :: list()
  def run(cf, i) do
    range = R.get(i)

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
        -> raise Errors.EvaluateError
    end
  end

  @spec run_for_cron(Cron.t()) :: ParsedCron.t()
  def run_for_cron(c) do
    %CronParser.ParsedCron {
      minutes: run(T.run(c.minutes), CronParser.Parser.Intervals.minutes()),
      hours: run(T.run(c.hours), CronParser.Parser.Intervals.hours()),
      day_of_month: run(T.run(c.day_of_month), CronParser.Parser.Intervals.day_of_month()),
      month: run(T.run(c.month), CronParser.Parser.Intervals.month),
      day_of_week: run(T.run(c.day_of_week), CronParser.Parser.Intervals.day_of_week())
    }
  end
end
