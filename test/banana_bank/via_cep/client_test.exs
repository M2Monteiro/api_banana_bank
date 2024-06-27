defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true

  alias BananaBank.ViaCep.Client, as: ViaCepClient

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "successfully return cep info", %{bypass: bypass} do
      cep = "66823089"

      expected_response = "banana"

      response = ViaCepClient.call(cep)

      assert response == expected_response
    end
  end
end
