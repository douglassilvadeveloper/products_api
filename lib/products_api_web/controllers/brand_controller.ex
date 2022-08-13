defmodule ProductsApiWeb.BrandController do
  use ProductsApiWeb, :controller

  alias ProductsApi.Products
  alias ProductsApi.Products.Brand
  alias ProductsApi.Repo

  action_fallback ProductsApiWeb.FallbackController

  def index(conn, _params) do
    brands = Products.list_brands()
    render(conn, "index.json", brands: brands)
  end

  def create(conn, %{"brand" => brand_params}) do
    with {:ok, %Brand{} = brand} <- Products.create_brand(brand_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.brand_path(conn, :show, brand))
      |> render("show_with_products.json", brand: brand |> Repo.preload([products: :category]))
    end
  end

  def show(conn, %{"id" => id}) do
    brand = Products.get_brand!(id)
    render(conn, "show_with_products.json", brand: brand)
  end

  def update(conn, %{"id" => id, "brand" => brand_params}) do
    brand = Products.get_brand!(id)

    with {:ok, %Brand{} = brand} <- Products.update_brand(brand, brand_params) do
      render(conn, "show_with_products.json", brand: brand |> Repo.preload([products: :category]))
    end
  end

  def delete(conn, %{"id" => id}) do
    brand = Products.get_brand!(id)

    with {:ok, %Brand{}} <- Products.delete_brand(brand) do
      send_resp(conn, :no_content, "")
    end
  end
end
