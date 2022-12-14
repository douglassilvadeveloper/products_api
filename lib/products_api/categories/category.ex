defmodule ProductsApi.Categories.Category do
  use Ecto.Schema
  import Ecto.Changeset
  import Slugy

  alias ProductsApi.Products.Product

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "categories" do
    field :name, :string
    field :slug, :string
    has_many :products, Product

    timestamps()
  end

  @doc false
  def changeset(category, attrs) do
    category
    |> cast(attrs, [:name])
    |> slugify(:name)
    |> validate_required([:name, :slug])
    |> unique_constraint(:name)
  end
end
