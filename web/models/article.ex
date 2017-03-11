defmodule CenatusLtd.Article do
  use CenatusLtd.Web, :model

  alias CenatusLtd.Tag
  alias CenatusLtd.Repo

  schema "articles" do
    field :title,         :string
    field :summary,       :string
    field :content,       :string
    field :image_url,     :string
    field :published_at,  Ecto.DateTime

    many_to_many :tags, CenatusLtd.Tag, join_through: "article_tags", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :summary, :content, :image_url, :published_at])
    |> put_assoc(:tags, parse_tags(params))
    |> validate_required([:title, :summary, :content, :published_at])
  end

  defp parse_tags(params)  do
    (params["tags"] || "")
      |> String.split(",")
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.downcase/1)
      |> Enum.uniq
      |> Enum.reject(& &1 == "")
      |> Enum.map(&get_or_insert_tag/1)
  end

  defp get_or_insert_tag(name) do
    Repo.get_by(CenatusLtd.Tag, name: name) || Repo.insert!(Tag.changeset(%Tag{}, %{name: name}))
  end
end
