defmodule Ifood.AccountsTest do
  use Ifood.DataCase, async: true
  doctest Ifood.Accounts.Users.GetById

  import Ifood.Factory

  alias Core.Error
  alias Ifood.Accounts
  alias Ifood.Accounts.User

  describe "get_user_by_id/1" do
    test "success" do
      params = build(:user_params)

      {:ok, %User{id: user_id}} = Accounts.create_user(params)

      response = Accounts.get_user_by_id(user_id)

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

      response = Accounts.get_user_by_id(id)

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end

  describe "delete_user/1" do
    test "success" do
      params = build(:user_params)

      {:ok, %User{id: created_user_id}} = Accounts.create_user(params)

      # user succesfully deleted
      assert {:ok, %User{id: deleted_user_id}} = Accounts.delete_user(created_user_id)

      # deleted user not found
      expected_response = {:error, %Error{result: "User not found", status: :not_found}}
      response = Accounts.get_user_by_id(deleted_user_id)
      assert response == expected_response
    end

    test "user not found" do
      %User{id: id} = build(:user)

      response = Accounts.delete_user(id)

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
