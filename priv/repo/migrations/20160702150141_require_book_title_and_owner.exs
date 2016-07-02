defmodule MicoseBackend.Repo.Migrations.RequireBookTitleAndOwner do
  use Ecto.Migration

  def change do
    alter table(:books) do
      modify :title, :string, null: false
      modify :owner, :string, null: false
    end
  end
end
