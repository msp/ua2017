defmodule CenatusLtd.Repo.Migrations.AddImagesToArticles do
  use Ecto.Migration

  def change do
    alter table(:articles) do
      add :image_url, :string
    end
  end
end
