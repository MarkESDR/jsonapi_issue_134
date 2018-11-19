defmodule JsonapiIssue134.Repo.Migrations.AddPostId do
  use Ecto.Migration

  def change do
    alter table(:comments) do
      add :post_id, references(:posts)
    end
  end
end
