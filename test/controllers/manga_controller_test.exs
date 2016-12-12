defmodule MicoseBackend.MangaControllerTest do
  use MicoseBackend.ConnCase

  alias MicoseBackend.Manga
  @valid_attrs %{collection: "some content", serie: "some content", title: "some content", tome: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, manga_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    manga = Repo.insert! %Manga{}
    conn = get conn, manga_path(conn, :show, manga)
    assert json_response(conn, 200)["data"] == %{"id" => manga.id,
      "collection" => manga.collection,
      "serie" => manga.serie,
      "title" => manga.title,
      "tome" => manga.tome,
      "book_id" => manga.book_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, manga_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, manga_path(conn, :create), manga: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Manga, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, manga_path(conn, :create), manga: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    manga = Repo.insert! %Manga{}
    conn = put conn, manga_path(conn, :update, manga), manga: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Manga, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    manga = Repo.insert! %Manga{}
    conn = put conn, manga_path(conn, :update, manga), manga: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    manga = Repo.insert! %Manga{}
    conn = delete conn, manga_path(conn, :delete, manga)
    assert response(conn, 204)
    refute Repo.get(Manga, manga.id)
  end
end
