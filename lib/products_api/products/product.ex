defmodule ProductsApi.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset
  import Slugy

  alias ProductsApi.Products.Brand
  alias ProductsApi.Categories.Category


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "products" do
    field :name, :string
    field :price, :decimal
    field :slug, :string
    belongs_to :brand, Brand
    belongs_to :category, Category

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :brand_id, :category_id])
    |> slugify(:name)
    |> validate_required([:name, :slug, :price, :brand_id, :category_id])
    |> unique_constraint([:name, :brand_id, :category_id])
  end
end
