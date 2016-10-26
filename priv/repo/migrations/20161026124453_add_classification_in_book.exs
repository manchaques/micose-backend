defmodule MicoseBackend.Repo.Migrations.AddClassificationInBook do
  use Ecto.Migration

  def up do
      alter table(:books) do
        add :classification_id, references(:classifications)
      end
    end

    def down do
      alter table(:books) do
        remove :classifications
      end
    end
end
