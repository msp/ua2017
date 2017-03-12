defmodule CenatusLtd.PageView do
  use CenatusLtd.Web, :view

  def handler_info(conn) do
    action_name conn
  end
end
