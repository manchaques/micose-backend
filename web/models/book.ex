defmodule MicoseBackend.Book do
  use MicoseBackend.Web, :model

  schema "books" do
    field :title, :string
    field :subtitle, :string
    belongs_to :owner, MicoseBackend.User, foreign_key: :owner_id
    belongs_to :borrower, MicoseBackend.User, foreign_key: :borrower_id

    timestamps()
  end

  @required_fields ~w(title owner_id)
  @optional_field ~w(subtitle borrower_id)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :subtitle, :owner_id, :borrower_id])
    |> validate_required([:title, :owner_id])
  end
end
