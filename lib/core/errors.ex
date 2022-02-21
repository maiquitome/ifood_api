defmodule Core.Errors do
  @moduledoc """
  Default Errors.
  """

  alias Core.Error

  def build_user_not_found_error, do: Error.build(:not_found, "User not found")
  def build_id_format_error, do: Error.build(:bad_request, "Invalid id format")
end
