defmodule MicoseBackend.ClassificationTest do
  use MicoseBackend.ModelCase

  alias MicoseBackend.Classification

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Classification.changeset(%Classification{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Classification.changeset(%Classification{}, @invalid_attrs)
    refute changeset.valid?
  end
end
