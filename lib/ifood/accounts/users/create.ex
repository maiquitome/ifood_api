defmodule Ifood.Accounts.Users.Create do
  @moduledoc """
  Module for creating a user.
  """
  alias Ifood.{Accounts.User, Repo}
  alias Core.{Error, Utils}

  @type attrs :: %{
          birthdate: String.t(),
          cpf: String.t(),
          email: String.t(),
          first_name: String.t(),
          last_name: String.t(),
          password: String.t(),
          password_confirmation: String.t(),
          password_hash: String.t(),
          phone_number: String.t()
        }

  @doc """
  ## Examples

      iex> {:ok, %Ifood.Accounts.User{birthdate: ~D[1993-05-13]}} =
      ...> %{
      ...>    "birthdate"             => "13/05/1993",
      ...>    "cpf"                   => "12345678911",
      ...>    "email"                 => "maiqui@email.com",
      ...>    "first_name"            => "Maiqui",
      ...>    "last_name"             => "Tomé",
      ...>    "password"              => "123456",
      ...>    "password_confirmation" => "123456",
      ...>    "phone_number"          => "54999269936"
      ...> } |> Ifood.Accounts.Users.Create.call

      iex> %{
      ...>    "birthdate"             => "13051993",
      ...>    "cpf"                   => "12345678911",
      ...>    "email"                 => "maiqui@email.com",
      ...>    "first_name"            => "Maiqui",
      ...>    "last_name"             => "Tomé",
      ...>    "password"              => "123456",
      ...>    "password_confirmation" => "123456",
      ...>    "phone_number"          => "54999269936"
      ...> } |> Ifood.Accounts.Users.Create.call
      {:error, %Core.Error{result: "Invalid date! Please pass in the correct format: 00/00/0000", status: :bad_request}}

  """
  @spec call(attrs()) ::
          {:ok, Ecto.Schema.t()}
          | {:error, %{status: :bad_request, result: Ecto.Changeset.t()}}
          | {:error, %{status: :bad_request, result: String.t()}}
  def call(%{"birthdate" => birthdate} = attrs) do
    case Utils.string_to_date(birthdate) do
      {:ok, date} ->
        attrs = %{attrs | "birthdate" => date}

        attrs
        |> User.changeset()
        |> Repo.insert()
        |> handle_insert()

      {:error, message} ->
        {:error, Error.build(:bad_request, message)}
    end
  end

  defp handle_insert({:ok, %User{}} = result), do: result

  defp handle_insert({:error, %Ecto.Changeset{} = changeset}) do
    {:error, Error.build(:bad_request, changeset)}
  end
end
