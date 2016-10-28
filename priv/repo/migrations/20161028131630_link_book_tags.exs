defmodule MicoseBackend.Repo.Migrations.LinkBookTags do
  use Ecto.Migration

  def change do
      create table(:books_tags, primary_key: false) do
        add :book_id, references(:books)
        add :tag_id, references(:tags)
      end
  end
end
