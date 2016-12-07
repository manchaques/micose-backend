defmodule MicoseBackend.Comics do
  use MicoseBackend.Web, :model

  schema "comics" do
    field :collection, :string
    field :serie, :string
    field :title, :string
    field :tome, :integer
    belongs_to :book, MicoseBackend.Book

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:collection, :serie, :title, :tome])
    |> validate_required([:collection, :serie, :title, :tome])
  end
end
