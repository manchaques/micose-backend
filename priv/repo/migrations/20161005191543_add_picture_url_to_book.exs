defmodule MicoseBackend.Repo.Migrations.AddPictureUrlToBook do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :cover_url, :string
    end
  end
end
