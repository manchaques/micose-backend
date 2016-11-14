defmodule MicoseBackend.Books_tags do
  use MicoseBackend.Web, :model


  @primary_key false
  schema "books_tags" do
    belongs_to :book, MicoseBackend.Book
    belongs_to :tag, MicoseBackend.Tag
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :tag_id])
    |> validate_required([:book_id, :tag_id])
  end
end
