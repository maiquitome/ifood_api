defmodule Ifood.Accounts do
  @moduledoc """
  Accounts Facade.
  """

  alias Ifood.Accounts.Users.Create, as: UserCreate
  alias Ifood.Accounts.Users.GetById, as: UserGetById

  defdelegate create_user(attrs), to: UserCreate, as: :call
  defdelegate get_user_by_id(id), to: UserGetById, as: :call
end
