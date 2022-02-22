defmodule Ifood.Accounts.UserTest do
  use Ifood.DataCase, async: true

  import Ifood.Factory

  alias Ecto.Changeset
  alias Ifood.Accounts.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:user_params)

      response = User.changeset(params)

      assert %Changeset{
               action: nil,
               changes: %{
                 birthdate: ~D[1993-05-13],
                 cpf: "12345678911",
                 email: "maiqui@email.com",
                 first_name: "Maiqui",
                 last_name: "Tomé",
                 password: "123456",
                 password_confirmation: "123456",
                 password_hash: _password_hash,
                 phone_number: "5496159531"
               },
               errors: [],
               data: %User{},
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = %{
        last_name: "Pirolli Tomé",
        password: "1234567",
        password_confirmation: "1234567"
      }

      existing_user = %User{
        birthdate: ~D[1993-05-13],
        cpf: "12345678911",
        email: "maiqui@email.com",
        first_name: "Maiqui",
        last_name: "Tomé",
        password: "123456",
        password_confirmation: "123456",
        password_hash: "agbnafbngklajbfglkjabfgj",
        phone_number: "5496159531"
      }

      response = User.changeset(existing_user, params)

      assert %Changeset{
               action: nil,
               changes: %{
                 last_name: "Pirolli Tomé",
                 password: "1234567",
                 password_confirmation: "1234567",
                 password_hash: _password_hash
               },
               errors: [],
               data: %User{},
               valid?: true
             } = response
    end

    test "when the password_confirmation is different from the password, returns an invalid changeset" do
      params = build(:user_params, %{"password_confirmation" => "111111"})

      expected_response = %{password_confirmation: ["does not match confirmation"]}

      response = User.changeset(params)

      assert errors_on(response) == expected_response
    end

    test "when the password is less than six characters, returns an invalid changeset" do
      params = build(:user_params, %{"password" => "12345", "password_confirmation" => "12345"})

      expected_response = %{password: ["should be at least 6 character(s)"]}

      response = User.changeset(params)

      assert errors_on(response) == expected_response
    end

    test "when the cpf is less than eleven characters, returns an invalid changeset" do
      params = build(:user_params, %{"cpf" => "1234567890"})

      expected_response = %{cpf: ["should be 11 character(s)"]}

      response = User.changeset(params)

      assert errors_on(response) == expected_response
    end

    test "when there is a blank field, returns an invalid changeset" do
      params = %{}

      expected_response = %{
        birthdate: ["can't be blank"],
        cpf: ["can't be blank"],
        email: ["can't be blank"],
        first_name: ["can't be blank"],
        last_name: ["can't be blank"],
        password: ["can't be blank"],
        password_confirmation: ["can't be blank"]
      }

      response = User.changeset(params)

      assert errors_on(response) == expected_response
    end

    test "when the format of the email field is invalid, returns an invalid changeset" do
      params = build(:user_params, %{"email" => "maiqui"})

      expected_response = %{email: ["has invalid format"]}

      response = User.changeset(params)

      assert errors_on(response) == expected_response
    end
  end
end
