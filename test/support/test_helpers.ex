defmodule CenatusLtd.TestHelpers do
  alias CenatusLtd.Repo
  alias CenatusLtd.Article

  def insert_article(attrs \\ %{}) do
      changes = Dict.merge(%{
                  "title" => "default title",
                  "summary" => "default summary",
                  "content" => "default content",
                  "published_at" => :calendar.universal_time(),
                  "tags" =>  ""
                  }, attrs)

      Article.changeset(%Article{}, changes)
        |>  Repo.insert!
  end
end
