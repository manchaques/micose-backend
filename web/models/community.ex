defmodule MicoseBackend.Community do
  use MicoseBackend.Web, :model

  schema "communities" do
    field :name, :string
    many_to_many :users, MicoseBackend.User, join_through: MicoseBackend.Users_Communities
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
