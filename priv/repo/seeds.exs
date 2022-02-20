# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Ifood.Repo.insert!(%Ifood.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Ifood.{Accounts.User, Repo}

{:ok, user} =
  %{
    birthdate: ~D[1993-05-13],
    cpf: "12345678911",
    email: "maiqui@email.com",
    first_name: "Maiqui",
    last_name: "Tomé",
    password: "123456",
    password_confirmation: "123456",
    phone_number: "5496159531"
  }
  |> User.changeset()
  |> Repo.insert()

User.changeset(user, %{last_name: "Pirolli Tomé"})
|> Repo.update()
