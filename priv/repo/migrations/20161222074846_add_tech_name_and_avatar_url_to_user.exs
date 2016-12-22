defmodule MicoseBackend.Repo.Migrations.AddTechNameAndAvatarUrlToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :techName, :string
      add :avatarUrl, :string
    end
  end
end
