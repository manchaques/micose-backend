defmodule MicoseBackend.UserTest do
  use MicoseBackend.ModelCase

  alias MicoseBackend.User

  @valid_attrs %{pseudo: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
