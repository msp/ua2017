defmodule CenatusLtd.PageController do
  use CenatusLtd.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
