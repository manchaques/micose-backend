defmodule MicoseBackend.Tag do
  use MicoseBackend.Web, :model

  schema "tags" do
    field :name, :string
    # For test only, probably useless to link books and tags from Tags
    many_to_many :books, MicoseBackend.Book, join_through: MicoseBackend.Books_tags
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
