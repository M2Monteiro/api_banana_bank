defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def index(conn, _params) do
    conn |> json(%{message: "Bem-vindo ao banana bank", status: :ok})
  end
end
