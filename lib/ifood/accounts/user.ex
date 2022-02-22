defmodule Ifood.Accounts.User do
  @moduledoc """
  User Schema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields ~w[
    birthdate
    cpf
    email
    first_name
    last_name
    password
    password_confirmation
  ]a

  @fields_that_can_be_changed [:phone_number] ++ @required_fields

  @derive {Jason.Encoder,
           only: [
             :id,
             :birthdate,
             :cpf,
             :first_name,
             :last_name,
             :email,
             :phone_number
           ]}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :birthdate, :date
    field :cpf, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :phone_number, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, attrs) when is_struct(user) and is_map(attrs) do
    user
    |> cast(attrs, @fields_that_can_be_changed)
    |> validate_required(@required_fields)
    |> validate_length(:cpf, is: 11)
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password)
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(changeset), do: changeset
end
