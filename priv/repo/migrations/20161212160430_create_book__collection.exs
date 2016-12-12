defmodule MicoseBackend.Repo.Migrations.CreateBook_Collection do
  use Ecto.Migration

  def change do
    create table(:book_collections) do
      add :book_id, references(:books, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :borrower_id, references(:users, on_delete: :nothing)

      timestamps()
    end
    create index(:book_collections, [:book_id])
    create index(:book_collections, [:user_id])
    create index(:book_collections, [:borrower_id])

  end
end
