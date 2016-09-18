defmodule MicoseBackend.Book do
  use MicoseBackend.Web, :model

  schema "books" do
    field :title, :string
    field :subtitle, :string
    field :owner, :string
    field :borrower, :string

    timestamps()
  end

  @required_fields ~w(title owner)
  @optional_field ~w(subtitle borrower)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :subtitle, :owner, :borrower])
    |> validate_required([:title, :owner])
  end
end
