defmodule JsonapiIssue134Web.PostView do
  use JSONAPI.View, type: "posts"

  def fields do
    [:name]
  end
end
