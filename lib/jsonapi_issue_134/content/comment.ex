defmodule JsonapiIssue134.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias JsonapiIssue134.Content.Post

  schema "comments" do
    field :body, :string
    belongs_to :post, Post

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :post_id])
    |> validate_required([:body, :post_id])
    |> foreign_key_constraint(:post_id)
  end
end
