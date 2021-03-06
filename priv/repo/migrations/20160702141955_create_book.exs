defmodule MicoseBackend.Repo.Migrations.CreateBook do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string
      add :owner, :string
      add :borrower, :string

      timestamps()
    end

  end
end
