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
      body = ~s({
        "bairro": "Coqueiro",
        "cep": "66823-089",
        "complemento": "Cj Maguari",
        "ddd": "91",
        "gia": "",
        "ibge": "1501402",
        "localidade": "Belém",
        "logradouro": "Alameda Vinte e Três",
        "siafi": "0427",
        "uf": "PA",
        "unidade": ""
      })

      expected_response =
        {:ok,
         %{
           "bairro" => "Coqueiro",
           "cep" => "66823-089",
           "complemento" => "Cj Maguari",
           "ddd" => "91",
           "gia" => "",
           "ibge" => "1501402",
           "localidade" => "Belém",
           "logradouro" => "Alameda Vinte e Três",
           "siafi" => "0427",
           "uf" => "PA",
           "unidade" => ""
         }}

      Bypass.expect(bypass, "GET", "/#{cep}/json", fn conn ->
        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = bypass.port |> endpoint_url() |> ViaCepClient.call(cep)

      assert response == expected_response
    end

    defp endpoint_url(port), do: "http://localhost:#{port}"
  end
end
