defmodule CronParser.Parser.Intervals do
  def minutes(), do: :minutes
  def hours(), do: :hours
  def day_of_month(), do: :day_of_month
  def month(), do: :month
  def day_of_week(), do: :day_of_week
end

defmodule CronParser.Parser.Intervals.Ranges do
  @type interval
    :: :minutes
    | :hours
    | :day_of_month
    | :month
    | :day_of_week

  @spec get(interval()) :: list()
  def get(input) do
    case input do
      :minutes -> Enum.to_list(0..59)
      :hours -> Enum.to_list(0..23)
      :day_of_month -> Enum.to_list(1..31)
      :month -> Enum.to_list(1..12)
      :day_of_week -> Enum.to_list(1..7)
    end
  end
end
