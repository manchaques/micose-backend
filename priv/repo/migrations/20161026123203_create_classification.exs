defmodule MicoseBackend.Repo.Migrations.CreateClassification do
  use Ecto.Migration

  def change do
    create table(:classifications) do
      add :name, :string

      timestamps()
    end

  end
end
