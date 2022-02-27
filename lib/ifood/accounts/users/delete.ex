defmodule Ifood.Accounts.Users.Delete do
  @moduledoc """
  Deletes a user from the database.
  """
  alias Core.Errors
  alias Ecto.Schema
  alias Ifood.{Accounts.User, Repo}

  @doc """

      iex> alias Ifood.Accounts
      ...> alias Ifood.Accounts.{User, Users.Delete}
      ...>
      ...> params = %{
      ...>    "birthdate"             => "13/05/1993",
      ...>    "cpf"                   => "12345678911",
      ...>    "email"                 => "maiqui@email.com",
      ...>    "first_name"            => "Maiqui",
      ...>    "last_name"             => "Tomé",
      ...>    "password"              => "123456",
      ...>    "password_confirmation" => "123456",
      ...>    "phone_number"          => "54999269936"
      ...> }
      ...>
      ...> {:ok, %User{id: id}} = Accounts.create_user(params)
      ...>
      ...> {:ok, %User{}} = Delete.call(id)

  """
  @spec call(id :: binary()) ::
          {:ok, Schema.t()}
          | {:error, %{result: String.t(), status: :not_found}}
  def call(id) when is_binary(id) do
    case Repo.get(User, id) do
      nil -> {:error, Errors.build_user_not_found_error()}
      user -> Repo.delete(user)
    end
  end
end
