defmodule MicoseBackend.CommunityControllerTest do
  use MicoseBackend.ConnCase

  alias MicoseBackend.Community
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, community_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    community = Repo.insert! %Community{}
    conn = get conn, community_path(conn, :show, community)
    assert json_response(conn, 200)["data"] == %{"id" => community.id,
      "name" => community.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, community_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, community_path(conn, :create), community: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Community, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, community_path(conn, :create), community: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    community = Repo.insert! %Community{}
    conn = put conn, community_path(conn, :update, community), community: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Community, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    community = Repo.insert! %Community{}
    conn = put conn, community_path(conn, :update, community), community: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    community = Repo.insert! %Community{}
    conn = delete conn, community_path(conn, :delete, community)
    assert response(conn, 204)
    refute Repo.get(Community, community.id)
  end
end
