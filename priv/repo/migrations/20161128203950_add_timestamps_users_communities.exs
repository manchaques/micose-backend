defmodule MicoseBackend.Repo.Migrations.AddTimestampsUsersCommunities do
  use Ecto.Migration

  def change do
    alter table(:users_communities) do
      timestamps()
    end
  end
end
