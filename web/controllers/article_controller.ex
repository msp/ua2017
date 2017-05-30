defmodule CenatusLtd.ArticleController do
  use CenatusLtd.Web, :controller

  alias CenatusLtd.Article

  def index(conn, _params) do
    articles =
      Repo.all(Article)
      |> Repo.preload(:tags)
      |> Repo.preload(:tech_tags)

    render(conn, "index.html", articles: articles)
  end

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render(conn, "new.html", changeset: changeset, tags: [], tech_tags: [])
  end

  def create(conn, %{"article" => article_params}) do
    changeset = Article.changeset(%Article{}, article_params)

    case Repo.insert(changeset) do
      {:ok, _article} ->
        conn
        |> put_flash(:info, "Article created successfully.")
        |> redirect(to: article_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset,
          tags: taglist_from(changeset.changes.tags),
          tech_tags: taglist_from(changeset.changes.tech_tags))
    end
  end

  def show(conn, %{"id" => id}) do
    main_article =
      Repo.get!(Article, id)
      |> Repo.preload(:tags)
      |> Repo.preload(:tech_tags)

    # TODO - some smarter SQL
    # TODO - remove self article
    # TODO - why can't we render link from ID?
    related_tags
      = Enum.at(main_article.tags, 0)
      |> Repo.preload(:articles)

    related_articles =
      if related_tags do
        Enum.reject(related_tags.articles, fn(a) -> a.id == main_article.id end)
      else
        []
      end

    render(conn, "show.html", article: main_article, related: related_articles)
  end

  def edit(conn, %{"id" => id}) do
    article =
      Repo.get!(Article, id)
      |> Repo.preload(:tags)
      |> Repo.preload(:tech_tags)

    changeset = Article.changeset(article)

    render(conn, "edit.html", article: article, changeset: changeset,
      tags: taglist_from(article.tags),
      tech_tags: taglist_from(article.tech_tags))
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article =
      Repo.get!(Article, id)
      |> Repo.preload(:tags)
      |> Repo.preload(:tech_tags)

    changeset = Article.changeset(article, article_params)

    case Repo.update(changeset) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated successfully.")
        |> redirect(to: article_path(conn, :show, article))
      {:error, changeset} ->
        render(conn, "edit.html", article: article, changeset: changeset,
          tags: taglist_from(article.tags),
          tech_tags: taglist_from(article.tech_tags))
    end
  end

  def delete(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(article)

    conn
    |> put_flash(:info, "Article deleted successfully.")
    |> redirect(to: article_path(conn, :index))
  end

  defp taglist_from(tags) do
    Enum.map(tags, fn(tag) -> tag.name end)
      |> Enum.join(", ")
  end
end
