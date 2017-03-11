defmodule CenatusLtd.ArticleController do
  use CenatusLtd.Web, :controller

  alias CenatusLtd.Article

  def index(conn, _params) do
    articles = Repo.all(Article)
    render(conn, "index.html", articles: articles)
  end

  def new(conn, _params) do
    changeset = Article.changeset(%Article{})
    render(conn, "new.html", changeset: changeset, tags: [])
  end

  def create(conn, %{"article" => article_params}) do
    changeset = Article.changeset(%Article{}, article_params)

    case Repo.insert(changeset) do
      {:ok, _article} ->
        conn
        |> put_flash(:info, "Article created successfully.")
        |> redirect(to: article_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, tags: taglist_from(changeset.changes.tags))
    end
  end

  def show(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)
    article = Repo.preload(article, :tags)
    render(conn, "show.html", article: article)
  end

  def edit(conn, %{"id" => id}) do
    article = Repo.get!(Article, id)
    article = Repo.preload(article, :tags)
    changeset = Article.changeset(article)
    render(conn, "edit.html", article: article, changeset: changeset, tags: taglist_from(article.tags))
  end

  def update(conn, %{"id" => id, "article" => article_params}) do
    article = Repo.get!(Article, id)
    article = Repo.preload(article, :tags)
    changeset = Article.changeset(article, article_params)

    case Repo.update(changeset) do
      {:ok, article} ->
        conn
        |> put_flash(:info, "Article updated successfully.")
        |> redirect(to: article_path(conn, :show, article))
      {:error, changeset} ->
        render(conn, "edit.html", article: article, changeset: changeset, tags: taglist_from(article.tags))
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
      |> Enum.join(",")
  end
end
