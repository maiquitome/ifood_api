defmodule Core.Utils.StringToDate do
  @moduledoc """
  Change string to date.
  """

  def call(string_date) when is_binary(string_date) do
    case String.split(string_date, "/", trim: true) do
      [day, month, year] ->
        year = String.to_integer(year)
        month = String.to_integer(month)
        day = String.to_integer(day)

        Date.new(year, month, day)

      _ ->
        {:error, "Invalid date! Please pass in the correct format: 00/00/0000"}
    end
  end
end
