defmodule Common.RulesTypes do
  @spec wildcard() :: :wildcard
  def wildcard, do: :wildcard
  @spec range() :: :range
  def range, do: :range
  @spec list() :: :list
  def list, do: :list
  @spec divisor() :: :divisor
  def divisor, do: :divisor
  @spec single_num() :: :single_num
  def single_num, do: :single_num
end
