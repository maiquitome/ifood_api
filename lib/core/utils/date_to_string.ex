defmodule Core.Utils.DateToString do
  @moduledoc """
  Change date to string.
  """

  @doc """
      iex> Utils.DateToString.call(~D[1993-05-13])
      "13/05/1993"
  """
  def call(date) when is_struct(date) do
    string_date = Date.to_string(date)

    [year, month, day] = String.split(string_date, "-")

    "#{day}/#{month}/#{year}"
  end
end
