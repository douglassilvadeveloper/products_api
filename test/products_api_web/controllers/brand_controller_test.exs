defmodule ProductsApiWeb.BrandControllerTest do
  use ProductsApiWeb.ConnCase

  import ProductsApi.ProductsFixtures

  alias ProductsApi.Products.Brand

  @create_attrs %{
    name: "some name",
    slug: "some slug"
  }
  @update_attrs %{
    name: "some updated name",
    slug: "some updated slug"
  }
  @invalid_attrs %{name: nil, slug: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all brands", %{conn: conn} do
      conn = get(conn, Routes.brand_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create brand" do
    test "renders brand when data is valid", %{conn: conn} do
      conn = post(conn, Routes.brand_path(conn, :create), brand: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.brand_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name",
               "slug" => "some slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.brand_path(conn, :create), brand: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update brand" do
    setup [:create_brand]

    test "renders brand when data is valid", %{conn: conn, brand: %Brand{id: id} = brand} do
      conn = put(conn, Routes.brand_path(conn, :update, brand), brand: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.brand_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name",
               "slug" => "some updated slug"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, brand: brand} do
      conn = put(conn, Routes.brand_path(conn, :update, brand), brand: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete brand" do
    setup [:create_brand]

    test "deletes chosen brand", %{conn: conn, brand: brand} do
      conn = delete(conn, Routes.brand_path(conn, :delete, brand))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.brand_path(conn, :show, brand))
      end
    end
  end

  defp create_brand(_) do
    brand = brand_fixture()
    %{brand: brand}
  end
end
