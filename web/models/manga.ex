defmodule MicoseBackend.Manga do
  use MicoseBackend.Web, :model

  schema "mangas" do
    field :collection, :string
    field :serie, :string
    field :title, :string
    field :tome, :integer
    belongs_to :book, MicoseBackend.Book, foreign_key: :book_id

    timestamps()
  end

  @required_fields ~w(serie tome)
  @optional_field ~w(title book_id collection)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:collection, :serie, :title, :tome, :book_id])
    |> validate_required([:serie, :tome])
  end
end