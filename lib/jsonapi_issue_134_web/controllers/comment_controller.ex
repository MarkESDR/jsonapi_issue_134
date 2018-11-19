defmodule JsonapiIssue134Web.CommentController do
  use JsonapiIssue134Web, :controller

  alias JsonapiIssue134.Content
  alias JsonapiIssue134.Content.Comment
  alias JsonapiIssue134Web.CommentView

  plug JSONAPI.QueryParser, [view: CommentView] when action in [:show]

  action_fallback JsonapiIssue134Web.FallbackController

  def index(conn, _params) do
    comments = Content.list_comments()
    render(conn, "index.json", data: comments)
  end

  def create(conn, %{"comment" => comment_params}) do
    with {:ok, %Comment{} = comment} <- Content.create_comment(comment_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.comment_path(conn, :show, comment))
      |> render("show.json", data: comment)
    end
  end

  def show(conn, %{"id" => id}) do
    include = get_in(conn, [Access.key(:assigns), :jsonapi_query, Access.key(:include)])
    comment = Content.get_comment!(id, include)
    render(conn, "show.json", data: comment)
  end

  def update(conn, %{"id" => id, "comment" => comment_params}) do
    comment = Content.get_comment!(id)

    with {:ok, %Comment{} = comment} <- Content.update_comment(comment, comment_params) do
      render(conn, "show.json", data: comment)
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Content.get_comment!(id)

    with {:ok, %Comment{}} <- Content.delete_comment(comment) do
      send_resp(conn, :no_content, "")
    end
  end
end
