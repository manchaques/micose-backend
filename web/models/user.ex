defmodule MicoseBackend.User do
  use MicoseBackend.Web, :model

  schema "users" do
    field :pseudo, :string
    has_many :books, MicoseBackend.Book, foreign_key: :owner_id, on_delete: :delete_all

    timestamps()
  end

  @required_fields ~w(pseudo)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:pseudo])
    |> validate_required([:pseudo])
  end
end
