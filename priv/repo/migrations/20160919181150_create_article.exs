defmodule CenatusLtd.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :summary, :text
      add :content, :text
      add :published_at, :datetime

      timestamps()
    end

  end
end
