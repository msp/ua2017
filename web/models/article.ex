defmodule CenatusLtd.Article do
  use CenatusLtd.Web, :model

  schema "articles" do
    field :title,         :string
    field :summary,       :string
    field :content,       :string
    field :image_url,     :string
    field :published_at,  Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :summary, :content, :image_url, :published_at])
    |> validate_required([:title, :summary, :content, :published_at])
  end
end
