defmodule CenatusLtd.PageController do
  use CenatusLtd.Web, :controller

  require Logger

  alias CenatusLtd.Article

  plug CenatusLtd.LoadAllTags
  plug :load_periodic

  def home(conn, params) do
    events(conn, params)
  end

  def events(conn, _params) do
    articles = get_articles_tagged_by("event")
    render(conn, CenatusLtd.SharedView, "articles.html", articles: articles)
  end

  def artists(conn, _params) do
    articles = get_articles_tagged_by("artist")
    render(conn, CenatusLtd.SharedView, "articles.html", articles: articles)
  end

  def info(conn, _params) do
    articles = get_articles_tagged_by("info")
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

  def contact(conn, _params) do
    render(conn, "contact.html")
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

  defp load_periodic(conn, _options) do
    conn = assign(conn, :tweets, CenatusLtd.Periodically.tweets)
    assign(conn, :tracks, CenatusLtd.Periodically.tracks)
  end
end
