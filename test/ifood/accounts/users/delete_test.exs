defmodule Ifood.Accounts.Users.DeleteTest do
  use Ifood.DataCase, async: true
  doctest Ifood.Accounts.Users.Delete

  import Ifood.Factory

  alias Core.Error
  alias Ifood.Accounts
  alias Ifood.Accounts.{User, Users.Delete}

  describe "call/1" do
    test "success" do
      %User{id: created_user_id} = insert(:user)

      # user succesfully deleted
      assert {:ok, %User{id: deleted_user_id}} = Delete.call(created_user_id)

      # deleted user not found
      expected_response = {:error, %Error{result: "User not found", status: :not_found}}
      response = Accounts.get_user_by_id(deleted_user_id)
      assert response == expected_response
    end

    test "user not found" do
      %User{id: id} = build(:user)

      response = Delete.call(id)

      expected_response = {:error, %Error{result: "User not found", status: :not_found}}

      assert response == expected_response
    end
  end
end
