defmodule CenatusLtd.ArticleTags do
  use CenatusLtd.Web, :model

  schema "article_tags" do
    belongs_to :article, CenatusLtd.Article
    belongs_to :tags, CenatusLtd.Tag
    timestamps()
  end
end
