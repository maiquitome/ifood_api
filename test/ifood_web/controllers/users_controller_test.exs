defmodule IfoodWeb.UserControllerTest do
  use IfoodWeb.ConnCase, async: true

  import Ifood.Factory

  alias Ifood.Accounts
  alias Ifood.Accounts.User

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

  describe "show/2" do
    test "success", %{conn: conn} do
      params = build(:user_params)

      {:ok, %User{id: id}} = Accounts.create_user(params)

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:ok)

      assert %{
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

    test "user not found", %{conn: conn} do
      id = "2fa33c83-9120-41fc-84f8-b402cfce8cfe"

      response =
        conn
        |> get(Routes.users_path(conn, :show, id))
        |> json_response(:not_found)

      expected_response = %{"error" => "User not found"}

      assert response == expected_response
    end

    test "invalid uuid", %{conn: conn} do
      invalid_id = "2fa33c83-9120-41fc-84f8-"

      response =
        conn
        |> get(Routes.users_path(conn, :show, invalid_id))
        |> json_response(:bad_request)

      expected_response = %{"error" => "Invalid UUID."}

      assert response == expected_response
    end
  end

  describe "delete/1" do
    test "success", %{conn: conn} do
      %User{id: id} = insert(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> response(:no_content)

      expected_response = ""

      assert response == expected_response
    end

    test "user not found", %{conn: conn} do
      %User{id: id} = build(:user)

      response =
        conn
        |> delete(Routes.users_path(conn, :delete, id))
        |> json_response(:not_found)

      expected_response = %{"error" => "User not found"}

      assert response == expected_response
    end
  end
end
