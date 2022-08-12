defmodule ProductsApi.ProductsTest do
  use ProductsApi.DataCase

  alias ProductsApi.Products

  describe "products" do
    alias ProductsApi.Products.Product

    import ProductsApi.ProductsFixtures

    @invalid_attrs %{inventory: nil, name: nil, price: nil, slug: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Products.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Products.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{inventory: 42, name: "some name", price: "120.5", slug: "some slug"}

      assert {:ok, %Product{} = product} = Products.create_product(valid_attrs)
      assert product.inventory == 42
      assert product.name == "some name"
      assert product.price == Decimal.new("120.5")
      assert product.slug == "some slug"
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_product(@invalid_attrs)
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()
      update_attrs = %{inventory: 43, name: "some updated name", price: "456.7", slug: "some updated slug"}

      assert {:ok, %Product{} = product} = Products.update_product(product, update_attrs)
      assert product.inventory == 43
      assert product.name == "some updated name"
      assert product.price == Decimal.new("456.7")
      assert product.slug == "some updated slug"
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_product(product, @invalid_attrs)
      assert product == Products.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Products.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Products.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Products.change_product(product)
    end
  end

  describe "brands" do
    alias ProductsApi.Products.Brand

    import ProductsApi.ProductsFixtures

    @invalid_attrs %{name: nil, slug: nil}

    test "list_brands/0 returns all brands" do
      brand = brand_fixture()
      assert Products.list_brands() == [brand]
    end

    test "get_brand!/1 returns the brand with given id" do
      brand = brand_fixture()
      assert Products.get_brand!(brand.id) == brand
    end

    test "create_brand/1 with valid data creates a brand" do
      valid_attrs = %{name: "some name", slug: "some slug"}

      assert {:ok, %Brand{} = brand} = Products.create_brand(valid_attrs)
      assert brand.name == "some name"
      assert brand.slug == "some slug"
    end

    test "create_brand/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Products.create_brand(@invalid_attrs)
    end

    test "update_brand/2 with valid data updates the brand" do
      brand = brand_fixture()
      update_attrs = %{name: "some updated name", slug: "some updated slug"}

      assert {:ok, %Brand{} = brand} = Products.update_brand(brand, update_attrs)
      assert brand.name == "some updated name"
      assert brand.slug == "some updated slug"
    end

    test "update_brand/2 with invalid data returns error changeset" do
      brand = brand_fixture()
      assert {:error, %Ecto.Changeset{}} = Products.update_brand(brand, @invalid_attrs)
      assert brand == Products.get_brand!(brand.id)
    end

    test "delete_brand/1 deletes the brand" do
      brand = brand_fixture()
      assert {:ok, %Brand{}} = Products.delete_brand(brand)
      assert_raise Ecto.NoResultsError, fn -> Products.get_brand!(brand.id) end
    end

    test "change_brand/1 returns a brand changeset" do
      brand = brand_fixture()
      assert %Ecto.Changeset{} = Products.change_brand(brand)
    end
  end
end
