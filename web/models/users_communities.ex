defmodule MicoseBackend.Users_Communities do
  use MicoseBackend.Web, :model

  @primary_key false
  schema "users_communities" do
    belongs_to :user, MicoseBackend.User
    belongs_to :community, MicoseBackend.Community

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :community_id])
    |> validate_required([:user_id, :community_id])
  end
end
