defmodule IfoodWeb.UsersView do
  use IfoodWeb, :view

  alias Ifood.Accounts.User

  def render("create.json", %{user: %User{birthdate: birthdate} = user}) do
    %{
      message: "User created!",
      user: Map.put(user, :birthdate, Core.Utils.date_to_string(birthdate))
    }
  end
end
