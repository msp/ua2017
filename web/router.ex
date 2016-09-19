defmodule CenatusLtd.Router do
  use CenatusLtd.Web, :router

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

  scope "/", CenatusLtd do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/articles", ArticleController
  end

  # Other scopes may use custom stacks.
  # scope "/api", CenatusLtd do
  #   pipe_through :api
  # end
end
