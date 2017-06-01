defmodule CenatusLtd.TagView do
  use CenatusLtd.Web, :view

  def article_count_for(tag) do
    length(tag.articles) + length(tag.tech_articles)
  end
end
