defmodule MicoseBackend.BookSpec do
  use ESpec.Phoenix, async: true, model: MicoseBackend.Book
  alias MicoseBackend.Book

  @valid_attrs %{
    title: "Test book",
    subtitle: "A subtitle",
    owner_id: 1,
    borrower_id: 2,
    classification_id: 3,
    cover_url: "Test cover"
  }
  @invalid_attrs %{}

  describe "validation" do
    #  Valid and invalid attributes
    it "checks changeset with valid attributes" do
      changeset = Book.changeset(%Book{}, @valid_attrs)
      assert changeset.valid?
    end
    it "checks changeset with invalid attributes" do
      changeset = Book.changeset(%Book{}, @invalid_attrs)
      refute changeset.valid?
    end

    # Required fields
    it "checks that title is required" do
      changeset = Book.changeset(%Book{}, Map.delete(@valid_attrs, :title))
      refute changeset.valid?
    end
    it "checks that owner_id is required" do
      changeset = Book.changeset(%Book{}, Map.delete(@valid_attrs, :owner_id))
      refute changeset.valid?
    end

    # Optional fields
    it "checks that subtitle is optional" do
      changeset = Book.changeset(%Book{}, Map.delete(@valid_attrs, :subtitle))
      assert changeset.valid?
    end
    it "checks that borrower_id is optional" do
      changeset = Book.changeset(%Book{}, Map.delete(@valid_attrs, :borrower_id))
      assert changeset.valid?
    end
    it "checks that classification is optional" do
      changeset = Book.changeset(%Book{}, Map.delete(@valid_attrs, :classification))
      assert changeset.valid?
    end
    it "checks that cover url is optional" do
      changeset = Book.changeset(%Book{}, Map.delete(@valid_attrs, :cover_url))
      assert changeset.valid?
    end
  end
end