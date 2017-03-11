defmodule CenatusLtd.Tag do
  use CenatusLtd.Web, :model

  schema "tags" do
    field :name, :string

    many_to_many :articles, CenatusLtd.Article, join_through: "article_tags", on_delete: :delete_all, on_replace: :delete

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
