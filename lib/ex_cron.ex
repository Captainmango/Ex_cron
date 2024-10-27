defmodule ExCron do
  @moduledoc """
  @TODO: fill this out
  """

  def main(args \\ []) do
    c = %Cron{
      minutes: Enum.at(args, 0),
      hours: Enum.at(args, 1),
      day_of_month: Enum.at(args, 2),
      month: Enum.at(args, 3),
      day_of_week: Enum.at(args, 4),
    }

    parsed_c = Parser.Evaluator.run_for_cron(c)

    Printer.print(ParsedCron.format(parsed_c))
  end
end
