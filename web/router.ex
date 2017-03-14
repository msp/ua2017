defmodule CenatusLtd.Router do
  use CenatusLtd.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CenatusLtd.Auth, repo: CenatusLtd.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CenatusLtd do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :home
    get "/login", SessionController, :new


    get "/creative", PageController, :creative
    get "/technology", PageController, :technology
    get "/production", PageController, :production

    get "/people", PageController, :people

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/admin", CenatusLtd do
    pipe_through [:browser, :authenticate_user]

    get "/", PageController, :admin

    resources "/articles", ArticleController
    resources "/tags", TagController
    resources "/users", UserController
  end


  # Other scopes may use custom stacks.
  # scope "/api", CenatusLtd do
  #   pipe_through :api
  # end
end
