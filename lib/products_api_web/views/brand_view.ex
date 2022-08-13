defmodule ProductsApiWeb.BrandView do
  use ProductsApiWeb, :view
  alias ProductsApiWeb.{BrandView, ProductView}

  def render("index.json", %{brands: brands}) do
    %{data: render_many(brands, BrandView, "brand_with_products.json")}
  end

  def render("show.json", %{brand: brand}) do
    %{data: render_one(brand, BrandView, "brand.json")}
  end

  def render("show_with_products.json", %{brand: brand}) do
    %{data: render_one(brand, BrandView, "brand_with_products.json")}
  end

  def render("brand.json", %{brand: brand}) do
    %{
      id: brand.id,
      name: brand.name,
      slug: brand.slug
    }
  end

  def render("brand_with_products.json", %{brand: brand}) do
    %{
      id: brand.id,
      name: brand.name,
      slug: brand.slug,
      products: render_many(brand.products, ProductView, "product_with_category.json")
    }
  end
end
