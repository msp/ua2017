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

    get "/events", PageController, :events
    get "/artists", PageController, :artists
    get "/info", PageController, :info

    get "/people", PageController, :people
    get "/about", PageController, :about
    get "/contact", PageController, :contact

    resources "/articles", ArticleController, only: [:show]
    resources "/tags", TagController, only: [:show]
    resources "/sessions", SessionController, only: [:new, :create, :delete]

    get "/sitemaps/sitemap1.xml", Redirector, external: "https://s3-eu-west-1.amazonaws.com/ua2017/sitemap1.xml"

    # Convenience redirects
    get "/compositional-constructs", Redirector, to: "/articles/2-compositional-constructs"
    get "/haptic-somatic", Redirector, to: "/articles/1-haptic-somatic"
    get "/narrativize", Redirector, to: "/articles/3-narrativize"
    get "/emotion-and-the-tech-no-body", Redirector, to: "/articles/4-emotion-the-tech-no-body"
    get "/tickets", Redirector, to: "/articles/43-unconscious-archives-festival-2017---tickets"
    get "/programme", Redirector, to: "/articles/6-unconscious-archives-festival-2017---programme"
    get "/sally-golding", Redirector, to: "/articles/42-sally-golding-director-producer-unconscious-archives"
  end

  scope "/admin", CenatusLtd do
    pipe_through [:browser, :authenticate_user]

    get "/", PageController, :admin

    resources "/articles", ArticleController, except: [:show]
    resources "/tags", TagController, except: [:show]
    resources "/users", UserController
  end


  # Other scopes may use custom stacks.
  # scope "/api", CenatusLtd do
  #   pipe_through :api
  # end
end
