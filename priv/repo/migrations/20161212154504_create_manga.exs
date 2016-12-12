defmodule MicoseBackend.Repo.Migrations.CreateManga do
  use Ecto.Migration

  def change do
    create table(:mangas) do
      add :collection, :string
      add :serie, :string
      add :title, :string
      add :tome, :integer
      add :book_id, references(:books, on_delete: :nothing)

      timestamps()
    end
    create index(:mangas, [:book_id])

  end
end
