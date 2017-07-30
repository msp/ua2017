defmodule CenatusLtd.Sitemaps do
  alias CenatusLtd.Repo
  alias CenatusLtd.Article
  alias CenatusLtd.Tag

  use Sitemap,
    host: "http://#{Application.get_env(:cenatus_ltd, CenatusLtd.Endpoint)[:url][:host]}",
    files_path: System.tmp_dir,
    public_path: "sitemaps/",
    compress: false

  alias CenatusLtd.{Endpoint, Router.Helpers}

  def generate do
    create do
      add "/events",      priority: 0.8, changefreq: "daily", expires: nil
      add "/artists",     priority: 0.8, changefreq: "daily", expires: nil
      add "/info",        priority: 0.8, changefreq: "daily", expires: nil
      add "/people",      priority: 0.8, changefreq: "daily", expires: nil
      add "/about",       priority: 0.8, changefreq: "daily", expires: nil

      Enum.map(Repo.all(Article), fn(article) ->
        add Helpers.article_path(Endpoint, :show, article), priority: 0.9, changefreq: "hourly", expires: nil
      end)

      Enum.map(Repo.all(Tag), fn(tag) ->
        add Helpers.tag_path(Endpoint, :show, tag), priority: 0.7, changefreq: "daily", expires: nil
      end)

      ping()
    end
  end
end
