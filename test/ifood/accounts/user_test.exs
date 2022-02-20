defmodule Ifood.Accounts.UserTest do
  use Ifood.DataCase, async: true

  alias Ecto.Changeset
  alias Ifood.Accounts.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        birthdate: ~D[1993-05-13],
        cpf: "12345678911",
        email: "maiqui@email.com",
        first_name: "Maiqui",
        last_name: "Tomé",
        password: "123456",
        password_confirmation: "123456",
        phone_number: "5496159531"
      }

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
      params = %{
        birthdate: ~D[1993-05-13],
        cpf: "12345678912",
        email: "maiqui12@email.com",
        first_name: "Maiqui",
        last_name: "Tomé",
        password: "123456",
        password_confirmation: "111111",
        phone_number: "5496159531"
      }

      response = User.changeset(params)

      assert %Changeset{
               errors: [
                 password_confirmation:
                   {"does not match confirmation", [validation: :confirmation]}
               ],
               valid?: false
             } = response
    end

    test "when the password is less than six characters, returns an invalid changeset" do
      params = %{
        birthdate: ~D[1993-05-13],
        cpf: "12345678912",
        email: "maiqui12@email.com",
        first_name: "Maiqui",
        last_name: "Tomé",
        password: "12345",
        password_confirmation: "12345",
        phone_number: "5496159531"
      }

      response = User.changeset(params)

      assert %Changeset{
               errors: [
                 password:
                   {"should be at least %{count} character(s)",
                    [count: 6, validation: :length, kind: :min, type: :string]}
               ],
               valid?: false
             } = response
    end

    test "when the cpf is less than eleven characters, returns an invalid changeset" do
      params = %{
        birthdate: ~D[1993-05-13],
        cpf: "123456789",
        email: "maiqui12@email.com",
        first_name: "Maiqui",
        last_name: "Tomé",
        password: "123456",
        password_confirmation: "123456",
        phone_number: "5496159531"
      }

      response = User.changeset(params)

      assert %Changeset{
               errors: [
                 cpf:
                   {"should be %{count} character(s)",
                    [count: 11, validation: :length, kind: :is, type: :string]}
               ],
               valid?: false
             } = response
    end

    test "when there is a blank field, returns an invalid changeset" do
      params = %{}

      response = User.changeset(params)

      assert %Changeset{
               errors: [
                 birthdate: {"can't be blank", [validation: :required]},
                 cpf: {"can't be blank", [validation: :required]},
                 email: {"can't be blank", [validation: :required]},
                 first_name: {"can't be blank", [validation: :required]},
                 last_name: {"can't be blank", [validation: :required]},
                 password: {"can't be blank", [validation: :required]},
                 password_confirmation: {"can't be blank", [validation: :required]}
               ],
               valid?: false
             } = response
    end

    test "when the format of the email field is invalid, returns an invalid changeset" do
      params = %{
        birthdate: ~D[1993-05-13],
        cpf: "12345678911",
        email: "email",
        first_name: "Maiqui",
        last_name: "Tomé",
        password: "123456",
        password_confirmation: "123456",
        phone_number: "5496159531"
      }

      response = User.changeset(params)

      assert %Changeset{
               errors: [email: {"has invalid format", [validation: :format]}],
               valid?: false
             } = response
    end
  end
end
