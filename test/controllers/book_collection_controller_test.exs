defmodule MicoseBackend.Book_CollectionControllerTest do
  use MicoseBackend.ConnCase

  alias MicoseBackend.Book_Collection
  @valid_attrs %{}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, book__collection_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    book__collection = Repo.insert! %Book_Collection{}
    conn = get conn, book__collection_path(conn, :show, book__collection)
    assert json_response(conn, 200)["data"] == %{"id" => book__collection.id,
      "book_id" => book__collection.book_id,
      "user_id" => book__collection.user_id,
      "borrower_id" => book__collection.borrower_id}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, book__collection_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, book__collection_path(conn, :create), book__collection: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Book_Collection, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, book__collection_path(conn, :create), book__collection: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    book__collection = Repo.insert! %Book_Collection{}
    conn = put conn, book__collection_path(conn, :update, book__collection), book__collection: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Book_Collection, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    book__collection = Repo.insert! %Book_Collection{}
    conn = put conn, book__collection_path(conn, :update, book__collection), book__collection: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    book__collection = Repo.insert! %Book_Collection{}
    conn = delete conn, book__collection_path(conn, :delete, book__collection)
    assert response(conn, 204)
    refute Repo.get(Book_Collection, book__collection.id)
  end
end
