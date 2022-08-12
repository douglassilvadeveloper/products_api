defmodule ProductsApi.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ProductsApi.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        inventory: 42,
        name: "some name",
        price: "120.5",
        slug: "some slug"
      })
      |> ProductsApi.Products.create_product()

    product
  end

  @doc """
  Generate a brand.
  """
  def brand_fixture(attrs \\ %{}) do
    {:ok, brand} =
      attrs
      |> Enum.into(%{
        name: "some name",
        slug: "some slug"
      })
      |> ProductsApi.Products.create_brand()

    brand
  end
end
