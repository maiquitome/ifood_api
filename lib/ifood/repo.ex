defmodule Ifood.Repo do
  use Ecto.Repo,
    otp_app: :ifood,
    adapter: Ecto.Adapters.Postgres
end
