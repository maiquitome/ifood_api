defmodule IfoodWeb.UserControllerTest do
  use IfoodWeb.ConnCase, async: true

  import Ifood.Factory

  describe "create/2" do
    test "success", %{conn: conn} do
      params = build(:user_params)

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "birthdate" => "13/05/1993",
                 "cpf" => "12345678911",
                 "email" => "maiqui@email.com",
                 "first_name" => "Maiqui",
                 "id" => _id,
                 "last_name" => "Tomé",
                 "phone_number" => "5496159531"
               }
             } = response
    end

    test "invalid date", %{conn: conn} do
      params = %{"birthdate" => "1305/1993"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "error" => "Invalid date! Please pass in the correct format: 00/00/0000"
      }

      assert response == expected_response
    end

    test "invalid changeset", %{conn: conn} do
      params = %{"birthdate" => "13/05/1993"}

      response =
        conn
        |> post(Routes.users_path(conn, :create, params))
        |> json_response(:bad_request)

      expected_response = %{
        "error" => %{
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"],
          "first_name" => ["can't be blank"],
          "last_name" => ["can't be blank"],
          "password" => ["can't be blank"],
          "password_confirmation" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end
end
