defmodule Ifood.Accounts do
  @moduledoc """
  Accounts Facade.
  """

  alias Ifood.Accounts.Users.Create, as: UserCreate

  defdelegate create_user(attrs), to: UserCreate, as: :call
end
