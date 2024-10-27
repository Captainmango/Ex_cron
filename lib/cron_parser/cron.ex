defmodule CronParser.ParsedCron do
  defstruct [:minutes, :hours, :day_of_month, :month, :day_of_week]

  @type t :: %__MODULE__{
    minutes: list(),
    hours: list(),
    day_of_month: list(),
    month: list(),
    day_of_week: list(),
  }

  @spec format(c::__MODULE__.t()) :: String.t()
  def format(c) do
    """
    minutes      | #{Enum.join(c.minutes, ",")}
    hours        | #{Enum.join(c.hours, ",")}
    day_of_month | #{Enum.join(c.day_of_month, ",")}
    month        | #{Enum.join(c.month, ",")}
    day_of_week  | #{Enum.join(c.day_of_week, ",")}
    """
  end
end

defmodule CronParser.Cron do
  defstruct [:minutes, :hours, :day_of_month, :month, :day_of_week]

  @type t :: %__MODULE__{
    minutes: String.t(),
    hours: String.t(),
    day_of_month: String.t(),
    month: String.t(),
    day_of_week: String.t(),
  }
end
