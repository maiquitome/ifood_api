defmodule IfoodWeb.UsersViewTest do
  use IfoodWeb.ConnCase, async: true

  import Phoenix.View
  import Ifood.Factory

  alias Ifood.Accounts.User
  alias IfoodWeb.UsersView

  test "renders create.json" do
    user = build(:user)

    response = render(UsersView, "create.json", user: user)

    assert %{
             message: "User created!",
             user: %User{
               birthdate: "13/05/1993",
               cpf: "12345678911",
               email: "maiqui@email.com",
               first_name: "Maiqui",
               id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a",
               inserted_at: _inserted_at,
               last_name: "Tomé",
               password: "123456",
               password_confirmation: "123456",
               password_hash: _password_hash,
               phone_number: "5496159531",
               updated_at: _updated_at
             }
           } = response
  end
end
