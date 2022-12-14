defmodule ProductsApiWeb.ProductController do
  use ProductsApiWeb, :controller

  alias ProductsApi.Products
  alias ProductsApi.Products.Product
  alias ProductsApi.Repo

  action_fallback ProductsApiWeb.FallbackController

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_path(conn, :show, product))
      |> render("show_with_brand_and_category.json", product: product |> Repo.preload([:brand, :category]))
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, "show_with_brand_and_category.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    with {:ok, %Product{} = product} <- Products.update_product(product, product_params) do
      render(conn, "show_with_brand_and_category.json", product: product |> Repo.preload([:brand, :category]))
    end
  end

  # def preload_handler()

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)

    with {:ok, %Product{}} <- Products.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
