defmodule MicoseBackend.Classification do
  use MicoseBackend.Web, :model

  schema "classifications" do
    field :name, :string
    has_many :classified_books, MicoseBackend.Book, foreign_key: :classification_id, on_delete: :delete_all
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
