defmodule Ifood.Factory do
  @moduledoc """
  Factory
  """
  use ExMachina.Ecto, repo: Ifood.Repo

  alias Ifood.Accounts.User

  def user_params_factory do
    %{
      "birthdate" => ~D[1993-05-13],
      "cpf" => "12345678911",
      "email" => "maiqui@email.com",
      "first_name" => "Maiqui",
      "last_name" => "Tomé",
      "password" => "123456",
      "password_confirmation" => "123456",
      "phone_number" => "5496159531"
    }
  end

  def user_factory do
    %User{
      birthdate: ~D[1993-05-13],
      cpf: "12345678911",
      email: "maiqui@email.com",
      first_name: "Maiqui",
      last_name: "Tomé",
      password: "123456",
      password_confirmation: "123456",
      phone_number: "5496159531",
      id: "b721fcad-e6e8-4e8f-910b-6911f2158b4a"
    }
  end
end
