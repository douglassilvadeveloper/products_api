defmodule ProductsApi.Repo.Migrations.CreateCategories do
  use Ecto.Migration

  def change do
    create table(:categories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, size: 50, null: false
      add :slug, :string

      timestamps()
    end
    create unique_index(:categories, [:name])
  end
end
