defmodule IfoodWeb.UsersController do
  @moduledoc """
  Module to create, edit, delete and show a user.
  """
  use IfoodWeb, :controller

  alias Ifood.{Accounts, Accounts.User}
  alias IfoodWeb.FallbackController

  action_fallback FallbackController

  def create(conn, attrs) do
    with {:ok, %User{} = user} <- Accounts.create_user(attrs) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Accounts.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render("user.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Accounts.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> text("")
    end
  end
end
