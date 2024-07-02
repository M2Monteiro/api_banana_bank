defmodule BananaBank.Accounts.Create do
  alias BananaBank.Repo
  alias BananaBank.Accounts.Account

  def call(params) do
    params
    |> Account.changeset()
    |> Repo.insert()
  end
end
