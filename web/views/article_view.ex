defmodule CenatusLtd.ArticleView do
  use CenatusLtd.Web, :view

  def render_tags_as_links_from(conn, tags) do
    tag_as_link = fn (tag) ->
      content_tag(:span,
                  content_tag(:a, tag.name, href: tag_path(conn, :show, tag), class: ""),
                  class: "tag")

    end

    Enum.map(tags, tag_as_link)
  end
end
