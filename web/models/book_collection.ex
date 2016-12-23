defmodule MicoseBackend.Book_Collection do
  use MicoseBackend.Web, :model

  schema "book_collections" do
    belongs_to :book, MicoseBackend.Book, foreign_key: :book_id
    belongs_to :user, MicoseBackend.User, foreign_key: :user_id
    belongs_to :borrower, MicoseBackend.User, foreign_key: :borrower_id

    timestamps()
  end

  @required_fields ~w(book_id user_id)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:book_id, :user_id, :borrower_id])
    |> validate_required([:book_id, :user_id])
  end
end
