defmodule ProductsApiWeb.ProductView do
  use ProductsApiWeb, :view
  alias ProductsApiWeb.{ProductView, BrandView, CategoryView}

  def render("index.json", %{products: products}) do
    %{data: render_many(products, ProductView, "product_with_brand_and_category.json")}
  end

  def render("show.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product.json")}
  end

  def render("show_with_brand_and_category.json", %{product: product}) do
    %{data: render_one(product, ProductView, "product_with_brand_and_category.json")}
  end

  def render("product.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      slug: product.slug,
      price: product.price,
      brand: product.brand_id,
      category: product.category_id
    }
  end
  def render("product_with_brand.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      slug: product.slug,
      price: product.price,
      brand: render_one(product.brand, BrandView, "brand.json")
    }
  end
  def render("product_with_brand_and_category.json", %{product: product}) do
    %{
      id: product.id,
      name: product.name,
      slug: product.slug,
      price: product.price,
      brand: render_one(product.brand, BrandView, "brand.json"),
      category: render_one(product.category, CategoryView, "category.json")
    }
  end
end
