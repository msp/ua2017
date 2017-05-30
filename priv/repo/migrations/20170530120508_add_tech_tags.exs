defmodule CenatusLtd.Repo.Migrations.AddTechTags do
  use Ecto.Migration

  def change do
    create table(:article_tech_tags, primary_key: false) do
      add :article_id, references(:articles)
      add :tag_id, references(:tags)
    end
  end
end
