defmodule MicoseBackend.Book do
  use MicoseBackend.Web, :model

  schema "books" do
    field :title, :string
    field :owner, :string
    field :borrower, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :owner, :borrower])
    |> validate_required([:title, :owner, :borrower])
  end
end
