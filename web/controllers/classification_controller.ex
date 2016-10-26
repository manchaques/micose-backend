defmodule MicoseBackend.ClassificationController do
  use MicoseBackend.Web, :controller

  alias MicoseBackend.Classification

  def index(conn, _params) do
    classifications = Repo.all(Classification)
    render(conn, "index.json", classifications: classifications)
  end

  def create(conn, %{"classification" => classification_params}) do
    changeset = Classification.changeset(%Classification{}, classification_params)

    case Repo.insert(changeset) do
      {:ok, classification} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", classification_path(conn, :show, classification))
        |> render("show.json", classification: classification)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    classification = Repo.get!(Classification, id)
    render(conn, "show.json", classification: classification)
  end

  def update(conn, %{"id" => id, "classification" => classification_params}) do
    classification = Repo.get!(Classification, id)
    changeset = Classification.changeset(classification, classification_params)

    case Repo.update(changeset) do
      {:ok, classification} ->
        render(conn, "show.json", classification: classification)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(MicoseBackend.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    classification = Repo.get!(Classification, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(classification)

    send_resp(conn, :no_content, "")
  end
end
