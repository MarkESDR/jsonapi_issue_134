defmodule JsonapiIssue134Web.CommentView do
  use JSONAPI.View, type: "comments"

  def fields do
    [:body]
  end
end
