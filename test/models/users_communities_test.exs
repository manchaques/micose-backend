defmodule MicoseBackend.Users_CommunitiesTest do
  use MicoseBackend.ModelCase

  alias MicoseBackend.Users_Communities

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Users_Communities.changeset(%Users_Communities{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Users_Communities.changeset(%Users_Communities{}, @invalid_attrs)
    refute changeset.valid?
  end
end
