defmodule Core.Utils do
  @moduledoc """
  Utils Facade.
  """

  alias Core.Utils.{DateToString, StringToDate}

  defdelegate date_to_string(date), to: DateToString, as: :call
  defdelegate string_to_date(string_date), to: StringToDate, as: :call
end
