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

  @spec run(cf::cron_fragment(), i::interval()) :: list()
  def run(cf, i) do
    range = Parser.Intervals.Ranges.get(i)

    case cf do
      {:wildcard} -> range
      _ -> [3]
    end
  end
end
