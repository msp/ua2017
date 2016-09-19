defmodule CenatusLtd.PageControllerTest do
  use CenatusLtd.ConnCase

  test "GET /", %{conn: conn} do
    first_article = insert_article(title: "first article")
    second_article = insert_article(title: "second article")
    third_article = insert_article(title: "third article")

    conn = get conn, "/"
    assert String.contains?(conn.resp_body, first_article.title)
    assert String.contains?(conn.resp_body, second_article.title)

    refute String.contains?(conn.resp_body, third_article.title)
  end
end
