defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User criado com sucesso",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}

  def update(%{user: user}), do: %{data: data(user), message: "User atualizado com sucesso"}

  defp data(%User{} = user) do
    %{id: user.id, name: user.name, cep: user.cep, email: user.email}
  end
end
