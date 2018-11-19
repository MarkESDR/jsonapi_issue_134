defmodule JsonapiIssue134Web.PostView do
  use JSONAPI.View, type: "comments"

  def fields do
    [:name]
  end
end
