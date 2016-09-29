defmodule MicoseBackend.Repo.Migrations.AssociateBooksWithUser do
  use Ecto.Migration

  def up do
    alter table(:books) do
      add :owner_id, references(:users)
      remove :owner
    end
  end

  def down do
    alter table(:books) do
      remove :owner_id
      add :owner, :string
    end
  end
end
