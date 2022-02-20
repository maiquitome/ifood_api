defmodule Ifood.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :birthdate, :date
      add :cpf, :string
      add :email, :string
      add :first_name, :string
      add :last_name, :string
      add :password_hash, :string
      add :phone_number, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:cpf])
  end
end
