defmodule BananaBankWeb.Support.UserFactory do
  use ExMachina.Ecto, repo: BananaBank.Repo

  alias BananaBank.Users.User

  def user_factory do
    %User{
      name: "Joe Makarov",
      email: sequence(:email, &"user#{&1}@example.com"),
      password: "12345678",
      password_hash: Pbkdf2.hash_pwd_salt("12345678"),
      cep: "01001000"
    }
  end

  def invalid_user_factory do
    %User{
      name: "Joe Makarov",
      email: sequence(:email, &"user#{&1}@example.com"),
      password: "12",
      cep: "010"
    }
  end
end
