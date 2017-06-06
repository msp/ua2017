defmodule Mix.Tasks.Sitemap.Generate do
  use Mix.Task

  @shortdoc "SEO Sitemap"

  def run(_args) do
    Mix.shell.info "starting sitemap generation..."
    CenatusLtd.Sitemaps.generate
    Mix.shell.info "DONE sitemap generation."
  end
end
