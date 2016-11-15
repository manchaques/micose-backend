defmodule MicoseBackend.Repo.Migrations.CreateUsers_Communities do
  use Ecto.Migration

  def change do
    create table(:users_communities, primary_key: false) do
      add :user_id, references(:users, on_delete: :nothing)
      add :community_id, references(:communities, on_delete: :nothing)
    end

  end
end
