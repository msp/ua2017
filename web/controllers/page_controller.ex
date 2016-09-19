defmodule CenatusLtd.PageController do
  use CenatusLtd.Web, :controller
  require Logger
  alias CenatusLtd.Article


  def index(conn, _params) do

    articles = Repo.all(from article in Article,
                      limit: 2,
                      order_by: [desc: article.published_at])

    render conn, "index.html", articles: articles
  end
end
