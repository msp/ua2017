defmodule CenatusLtd.PageController do
  use CenatusLtd.Web, :controller

  require Logger

  alias CenatusLtd.Article
  alias CenatusLtd.Tag

  plug :load_all_tags


  def index(conn, _params) do

    articles = Repo.all(from article in Article,
                      limit: 2,
                      order_by: [desc: article.published_at])

    render(conn, "index.html", articles: articles)
  end

  def creative(conn, _params) do
    articles = get_articles_tagged_by("creative")
    render(conn, "index.html", articles: articles)
  end

  def technology(conn, _params) do
    articles = get_articles_tagged_by("technology")
    render(conn, "index.html", articles: articles)
  end

  def production(conn, _params) do
    articles = get_articles_tagged_by("production")
    render(conn, "index.html", articles: articles)
  end

  defp get_articles_tagged_by(tag_name) do
    Repo.all(
      from a in Article,
      join: t in assoc(a, :tags),
      preload: [tags: t],
      where: t.name in ^[tag_name]
    )
  end

  defp load_all_tags(conn, _) do
    assign(conn, :tags, Repo.all(Tag))
  end
end
