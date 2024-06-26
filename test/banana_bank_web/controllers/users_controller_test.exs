defmodule BananaBankWeb.UserControllerTest do
  import BananaBankWeb.Support.UserFactory

  use BananaBankWeb.ConnCase

  describe "create/2" do
    test "successfully create an user", %{conn: conn} do
      user =
        build(:user)
        |> Map.from_struct()
        |> Map.drop([:id, :inserted_at, :updated_at])

      name = user.name
      cep = user.cep
      email = user.email

      response = conn |> post(~p"/api/users", user) |> json_response(:created)

      assert %{
               "data" => %{
                 "id" => _id,
                 "name" => ^name,
                 "email" => ^email,
                 "cep" => ^cep
               },
               "message" => "User criado com sucesso"
             } = response
    end

    test "when there are invalid params, returns an error", %{conn: conn} do
      invalid_user_params =
        build(:invalid_user)
        |> Map.from_struct()
        |> Map.drop([:id, :inserted_at, :updated_at])

      response = conn |> post(~p"/api/users", invalid_user_params) |> json_response(:bad_request)

      expected_response = %{
        "error" => %{
          "cep" => ["should be 8 character(s)"],
          "password" => ["should be at least 8 character(s)"]
        }
      }

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "successfully deleted a user", %{conn: conn} do
      user = insert(:user)

      conn = delete(conn, ~p"/api/users/#{user.id}")
      assert response(conn, :no_content)
    end

    test "when to delete a user that doesn't exist", %{conn: conn} do
      response = conn |> delete(~p"/api/users/99") |> json_response(:not_found)

      expected_response = %{"message" => "User not found", "status" => "not_found"}

      assert response == expected_response
    end
  end

  describe "show/2" do
    test "successfully show a user", %{conn: conn} do
      user = insert(:user)

      response = conn |> get(~p"/api/users/#{user.id}") |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "id" => user.id,
          "name" => user.name,
          "email" => user.email,
          "cep" => user.cep
        }
      }

      assert response == expected_response
    end

    test "when to show a user that doesn't exist", %{conn: conn} do
      response = conn |> get(~p"/api/users/99") |> json_response(:not_found)

      expected_response = %{
        "message" => "User not found",
        "status" => "not_found"
      }

      assert response == expected_response
    end
  end

  describe "update/2" do
    test "successfully update a user", %{conn: conn} do
      user = insert(:user)

      update_params = %{
        name: "Joe Makarov Clank",
        cep: "87654321"
      }

      response = conn |> put(~p"/api/users/#{user.id}", update_params) |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "id" => user.id,
          "name" => update_params.name,
          "email" => user.email,
          "cep" => update_params.cep
        },
        "message" => "User atualizado com sucesso"
      }

      assert response == expected_response
    end

    test "when to update a user that doesn't exist", %{conn: conn} do
      response = conn |> put(~p"/api/users/99") |> json_response(:not_found)

      expected_response = %{
        "message" => "User not found",
        "status" => "not_found"
      }

      assert response == expected_response
    end
  end
end
