defmodule MicoseBackend.User do
  use MicoseBackend.Web, :model

  schema "users" do
    field :pseudo, :string
    field :techName, :string
    field :avatarUrl, :string
    has_many :books, MicoseBackend.Book, foreign_key: :owner_id, on_delete: :delete_all
    has_many :borrowed_books, MicoseBackend.Book, foreign_key: :borrower_id
    many_to_many :communities, MicoseBackend.Community, join_through: MicoseBackend.Users_Communities
    timestamps()
  end

  @required_fields ~w(pseudo techName avatarUrl)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:pseudo, :techName, :avatarUrl])
    |> validate_required([:pseudo, :techName, :avatarUrl])
  end
end
