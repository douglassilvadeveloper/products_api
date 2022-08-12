defmodule ProductsApiWeb.CategoryView do
  use ProductsApiWeb, :view
  alias ProductsApiWeb.{CategoryView, ProductView}

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, CategoryView, "category_with_products.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category.json")}
  end
  def render("show_with_products.json", %{category: category}) do
    %{data: render_one(category, CategoryView, "category_with_products.json")}
  end

  def render("category.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name,
      slug: category.slug
    }
  end
  def render("category_with_products.json", %{category: category}) do
    %{
      id: category.id,
      name: category.name,
      slug: category.slug,
      products: render_many(category.products, ProductView, "product_with_brand.json")
    }
  end
end
