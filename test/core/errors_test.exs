defmodule Core.ErrorsTest do
  use ExUnit.Case

  alias Core.{Error, Errors}

  test "build_user_not_found_error/0" do
    response = Errors.build_user_not_found_error()

    expected_response = %Error{result: "User not found", status: :not_found}

    assert response == expected_response
  end

  test "build_id_format_error/0" do
    response = Errors.build_id_format_error()

    expected_response = %Error{result: "Invalid id format", status: :bad_request}

    assert response == expected_response
  end
end
