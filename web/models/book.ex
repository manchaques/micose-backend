defmodule MicoseBackend.Book do
  use MicoseBackend.Web, :model

  schema "books" do
    field :title, :string
    field :subtitle, :string
    belongs_to :owner, MicoseBackend.User, foreign_key: :owner_id
    belongs_to :borrower, MicoseBackend.User, foreign_key: :borrower_id
    belongs_to :classification, MicoseBackend.Classification, foreign_key: :classification_id
    many_to_many :tags, MicoseBackend.Tag, join_through: MicoseBackend.Books_tags
    field :cover_url, :string
    timestamps()
  end

  @required_fields ~w(title owner_id)
  @optional_field ~w(subtitle borrower_id cover_url classification_id)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :subtitle, :owner_id, :borrower_id, :classification_id, :cover_url])
    |> validate_required([:title, :owner_id])
  end
end
