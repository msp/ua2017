defmodule CenatusLtd.Repo.Migrations.AddSlugs do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :slug, :string
    end

    create index(:articles, [:slug], unique: true)

    alter table(:tags) do
      add :slug, :string
    end

    create index(:tags, [:slug], unique: true)
  end
end
