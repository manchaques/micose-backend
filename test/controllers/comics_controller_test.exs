defmodule MicoseBackend.ComicsControllerTest do
  use MicoseBackend.ConnCase

  alias MicoseBackend.Comics
  @valid_attrs %{collection: "some content", serie: "some content", title: "some content", tome: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, comics_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    comics = Repo.insert! %Comics{}
    conn = get conn, comics_path(conn, :show, comics)
    assert json_response(conn, 200)["data"] == %{"id" => comics.id,
      "collection" => comics.collection,
      "serie" => comics.serie,
      "title" => comics.title,
      "tome" => comics.tome,
      "book_id" => comics.book_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, comics_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, comics_path(conn, :create), comics: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Comics, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, comics_path(conn, :create), comics: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    comics = Repo.insert! %Comics{}
    conn = put conn, comics_path(conn, :update, comics), comics: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Comics, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    comics = Repo.insert! %Comics{}
    conn = put conn, comics_path(conn, :update, comics), comics: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    comics = Repo.insert! %Comics{}
    conn = delete conn, comics_path(conn, :delete, comics)
    assert response(conn, 204)
    refute Repo.get(Comics, comics.id)
  end
end
