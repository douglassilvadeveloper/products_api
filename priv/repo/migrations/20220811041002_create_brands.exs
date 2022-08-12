defmodule ProductsApi.Repo.Migrations.CreateBrands do
  use Ecto.Migration

  def change do
    create table(:brands, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, size: 50, null: false
      add :slug, :string

      timestamps()
    end
    create unique_index(:brands, [:name])
  end
end
