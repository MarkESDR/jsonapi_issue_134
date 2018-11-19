defmodule JsonapiIssue134Web.PageController do
  use JsonapiIssue134Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
