defmodule MicoseBackend.Repo.Migrations.CreateComics do
  use Ecto.Migration

  def change do
    create table(:comics) do
      add :collection, :string
      add :serie, :string
      add :title, :string
      add :tome, :integer
      add :book_id, references(:books, on_delete: :nothing)

      timestamps()
    end
    create index(:comics, [:book_id])

  end
end
