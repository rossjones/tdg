defmodule TDG.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :slug, :string
      add :content, :text

      timestamps()
    end

  end
end
