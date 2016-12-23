defmodule MicoseBackend.Book_CollectionTest do
  use MicoseBackend.ModelCase

  alias MicoseBackend.Book_Collection

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Book_Collection.changeset(%Book_Collection{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Book_Collection.changeset(%Book_Collection{}, @invalid_attrs)
    refute changeset.valid?
  end
end
