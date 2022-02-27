defmodule IfoodWeb.RouterTest do
  use IfoodWeb.ConnCase, async: true
  use Plug.Test

  alias IfoodWeb.Router

  @opts Router.init([])

  describe "show user" do
    test "valid uuid, but user not found" do
      conn =
        :get
        |> conn("/api/users/2fa33c83-9120-41fc-84f8-b402cfce8cfe")
        |> Router.call(@opts)

      assert conn.path_params == %{"id" => "2fa33c83-9120-41fc-84f8-b402cfce8cfe"}
      assert conn.state == :sent
      assert conn.status == 404
      assert conn.resp_body == "{\"error\":\"User not found\"}"
    end

    test "invalid uuid" do
      conn =
        :get
        |> conn("/api/users/2fa33c83-9120-41fc-84f8-")
        |> Router.call(@opts)

      assert conn.path_params == %{"id" => "2fa33c83-9120-41fc-84f8-"}
      assert conn.state == :sent
      assert conn.status == 400
      assert conn.resp_body == "{\"error\":\"Invalid UUID.\"}"
    end
  end
end
