defmodule CenatusLtd.PageControllerTest do
  use CenatusLtd.ConnCase

  test "GET /", %{conn: conn} do
    event_article = insert_article(%{"title" => "event article", "tags" => "event"})
    artist_article = insert_article(%{"title" => "artist article"})
    info_article = insert_article(%{"title" => "info article"})

    conn = get conn, "/"

    assert String.contains?(conn.resp_body, event_article.title)

    refute String.contains?(conn.resp_body, artist_article.title)
    refute String.contains?(conn.resp_body, info_article.title)
  end

  test "GET tag specific pages", %{conn: conn} do
    event_article = insert_article(%{"title" => "event article", "tags" => "event"})
    artist_article = insert_article(%{"title" => "artist article", "tags" => "artist"})
    info_article = insert_article(%{"title" => "info article", "tags" => "info"})

    conn = get conn, "/events"

    assert String.contains?(conn.resp_body, event_article.title)

    refute String.contains?(conn.resp_body, artist_article.title)
    refute String.contains?(conn.resp_body, info_article.title)

    conn = get conn, "/artists"

    assert String.contains?(conn.resp_body, artist_article.title)

    refute String.contains?(conn.resp_body, event_article.title)
    refute String.contains?(conn.resp_body, info_article.title)

    conn = get conn, "/info"

    assert String.contains?(conn.resp_body, info_article.title)

    refute String.contains?(conn.resp_body, event_article.title)
    refute String.contains?(conn.resp_body, artist_article.title)
  end

  test "GET /people", %{conn: conn} do
    matt_article = insert_article(%{"title" => "matt spendlove", "tags" => "person"})
    andi_article = insert_article(%{"title" => "andi studer", "tags" => "person"})
    info_article = insert_article(%{"title" => "production article", "tags" => "production"})

    conn = get conn, "/people"

    assert String.contains?(conn.resp_body, matt_article.title)
    assert String.contains?(conn.resp_body, andi_article.title)

    refute String.contains?(conn.resp_body, info_article.title)
  end
end
