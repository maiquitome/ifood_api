defmodule Core.ErrorTest do
  use ExUnit.Case

  alias Core.Error
  alias Ecto.Changeset

  describe "build/2" do
    test "result as binary" do
      status = :bad_request
      result = "there is a error"

      response = Error.build(status, result)

      expected_response = %Error{result: "there is a error", status: :bad_request}

      assert response == expected_response
    end

    test "result as changeset" do
      status = :bad_request

      result = %Changeset{
        errors: [password_confirmation: ["does not match confirmation"]],
        valid?: false
      }

      response = Error.build(status, result)

      expected_response = %Error{
        result: %Changeset{
          errors: [password_confirmation: ["does not match confirmation"]],
          valid?: false
        },
        status: :bad_request
      }

      assert response == expected_response
    end
  end
end
