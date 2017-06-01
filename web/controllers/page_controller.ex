defmodule CenatusLtd.PageController do
  use CenatusLtd.Web, :controller

  require Logger

  alias CenatusLtd.Article
  alias CenatusLtd.Tag

  plug :load_all_tags

  def home(conn, _params) do
    articles = Repo.all(from article in Article,
                      limit: 2,
                      order_by: [desc: article.published_at])

    render(conn, CenatusLtd.SharedView, "articles.html", articles: articles)
  end

  def creative(conn, _params) do
    articles = get_articles_tagged_by("creative")
    render(conn, CenatusLtd.SharedView, "articles.html", articles: articles)
  end

  def technology(conn, _params) do
    articles = get_articles_tagged_by("technology")
    render(conn, CenatusLtd.SharedView, "articles.html", articles: articles)
  end

  def production(conn, _params) do
    articles = get_articles_tagged_by("production")
    render(conn, CenatusLtd.SharedView, "articles.html", articles: articles)
  end

  def people(conn, _params) do
    articles = get_articles_tagged_by("person")
    render(conn, CenatusLtd.SharedView, "articles.html", articles: articles)
  end

  def about(conn, _params) do
    articles = get_articles_tagged_by("about")
    render(conn, CenatusLtd.SharedView, "articles.html", articles: articles)
  end

  def admin(conn, _params) do
    render(conn, "admin.html")
  end

  defp get_articles_tagged_by(tag_name) do
    Repo.all(
      from a in Article,
      join: t in assoc(a, :tags),
      preload: [tags: t],
      where: t.name in ^[tag_name],
      order_by: [desc: a.published_at]
    )
  end

  defp load_all_tags(conn, _) do
    tags_query =
      from tag in Tag,
      join: a in assoc(tag, :articles),
      group_by: [tag.name, tag.id],
      having: count(tag.id) >= 1,
      select: [tag]

    tech_tags_query =
      from tag in Tag,
      join: ta in assoc(tag, :tech_articles),
      group_by: [tag.name, tag.id],
      having: count(tag.id) >= 1,
      select: [tag]

    results = Repo.all(tags_query) ++ Repo.all(tech_tags_query)

    tags =
      Enum.map(results, fn(res) -> Enum.at(res, 0) end)

    assign(conn, :tags, tags)
  end
end
