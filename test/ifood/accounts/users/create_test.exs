defmodule Ifood.Accounts.Users.CreateTest do
  use Ifood.DataCase, async: true
  doctest Ifood.Accounts.Users.Create

  import Ifood.Factory

  alias Core.Error
  alias Ifood.Accounts.{User, Users.Create}

  describe "call/1" do
    test "success" do
      params = build(:user_params, %{"birthdate" => "13/05/1993"})

      assert {:ok,
              %User{
                birthdate: ~D[1993-05-13],
                cpf: "12345678911",
                email: "maiqui@email.com",
                first_name: "Maiqui",
                id: _id,
                inserted_at: _inserted_at,
                last_name: "Tomé",
                password: "123456",
                password_confirmation: "123456",
                password_hash: _password_hash,
                phone_number: "5496159531",
                updated_at: _updated_at
              }} = Create.call(params)
    end

    test "invalid date" do
      params = build(:user_params, %{"birthdate" => "1305/1993"})

      expected_response =
        {:error,
         %Error{
           result: "Invalid date! Please pass in the correct format: 00/00/0000",
           status: :bad_request
         }}

      response = Create.call(params)

      assert response == expected_response
    end

    test "invalid changeset" do
      params =
        build(
          :user_params,
          %{"birthdate" => "13/05/1993", "email" => "maiqui", "cpf" => "1234567890"}
        )

      expected_response = %{email: ["has invalid format"], cpf: ["should be 11 character(s)"]}

      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response
      assert errors_on(changeset) == expected_response
    end
  end
end
