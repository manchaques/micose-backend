defmodule MicoseBackend.ClassificationControllerTest do
  use MicoseBackend.ConnCase

  alias MicoseBackend.Classification
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, classification_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    classification = Repo.insert! %Classification{}
    conn = get conn, classification_path(conn, :show, classification)
    assert json_response(conn, 200)["data"] == %{"id" => classification.id,
      "name" => classification.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, classification_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, classification_path(conn, :create), classification: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Classification, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, classification_path(conn, :create), classification: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    classification = Repo.insert! %Classification{}
    conn = put conn, classification_path(conn, :update, classification), classification: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Classification, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    classification = Repo.insert! %Classification{}
    conn = put conn, classification_path(conn, :update, classification), classification: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    classification = Repo.insert! %Classification{}
    conn = delete conn, classification_path(conn, :delete, classification)
    assert response(conn, 204)
    refute Repo.get(Classification, classification.id)
  end
end
