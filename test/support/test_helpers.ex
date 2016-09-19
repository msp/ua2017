defmodule CenatusLtd.TestHelpers do
  alias CenatusLtd.Repo
  require Logger

  def insert_article(attrs \\ %{}) do
      changes = Dict.merge(%{
                      title: "a title",
                      summary: "a summary",
                      content: "a content",
                      published_at: :calendar.universal_time(),
                      }, attrs)
      %CenatusLtd.Article{}
      |> CenatusLtd.Article.changeset(changes)
      |> Repo.insert!()
  end
end
