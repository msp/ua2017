defmodule CenatusLtd.ArticleTest do
  use CenatusLtd.ModelCase

  alias CenatusLtd.Article

  @valid_attrs %{content: "some content", published_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}, summary: "some content", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Article.changeset(%Article{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Article.changeset(%Article{}, @invalid_attrs)
    refute changeset.valid?
  end
end
