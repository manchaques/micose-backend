defmodule MicoseBackend.ComicsTest do
  use MicoseBackend.ModelCase

  alias MicoseBackend.Comics

  @valid_attrs %{collection: "some content", serie: "some content", title: "some content", tome: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Comics.changeset(%Comics{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Comics.changeset(%Comics{}, @invalid_attrs)
    refute changeset.valid?
  end
end
