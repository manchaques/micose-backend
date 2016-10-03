defmodule MicoseBackend.Repo.Migrations.RefactorBorrowerWithUser do
  use Ecto.Migration

  def up do
      alter table(:books) do
        add :borrower_id, references(:users)
        remove :borrower
      end
    end

    def down do
      alter table(:books) do
        remove :borrower_id
        add :borrower, :string
      end
    end
end
