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
end
