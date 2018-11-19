defmodule JsonapiIssue134Web.CommentView do
  use JSONAPI.View, type: "comments"

  def fields do
    [:body]
  end

  def relationships do
    [post: JsonapiIssue134Web.PostView]
  end
end
