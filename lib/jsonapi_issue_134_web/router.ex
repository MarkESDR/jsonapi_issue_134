defmodule JsonapiIssue134Web.Router do
  use JsonapiIssue134Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JsonapiIssue134Web do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", JsonapiIssue134Web do
    pipe_through :api

    resources "/posts", PostController, except: [:new, :edit]
  end
end
