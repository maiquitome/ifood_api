defmodule Ifood.Accounts.Users.GetByIdTest do
  use Ifood.DataCase, async: true
  doctest Ifood.Accounts.Users.GetById

  import Ifood.Factory

  alias Core.Error
  alias Ifood.Accounts
  alias Ifood.Accounts.{User, Users.GetById}

  describe "call/1" do
    test "success" do
      params = build(:user_params)

      {:ok, %User{id: user_id}} = Accounts.create_user(params)

      response = GetById.call(user_id)

      assert {:ok,
              %User{
                birthdate: ~D[1993-05-13],
                cpf: "12345678911",
                email: "maiqui@email.com",
                first_name: "Maiqui",
                id: _,
                inserted_at: _,
                last_name: "Tomé",
                password: nil,
                password_confirmation: nil,
                password_hash: _,
                phone_number: "5496159531",
                updated_at: _
              }} = response
    end

    test "user not found" do
      id = "2fa33c83-9120-41fc-84f8-b402cfce8cfe"

      response = GetById.call(id)

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
