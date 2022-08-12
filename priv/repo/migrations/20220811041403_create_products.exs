defmodule ProductsApi.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, size: 50, null: false
      add :slug, :string
      add :price, :decimal, precision: 10, scale: 2
      add :brand_id, references(:brands, on_delete: :restrict, type: :binary_id), null: false
      add :category_id, references(:categories, on_delete: :restrict, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:products, [:category_id, :brand_id, :name])
  end
end
