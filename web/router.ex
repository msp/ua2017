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
    get "/about", PageController, :about
    get "/contact", PageController, :contact

    resources "/articles", ArticleController, only: [:show]
    resources "/tags", TagController, only: [:show]
    resources "/sessions", SessionController, only: [:new, :create, :delete]


    # Archive redirects
    get "/projects", Redirector, to: "/"
    get "/projects/2", Redirector, to: "/articles/1-sam-cafe-oto-commission"
    get "/web-design", Redirector, to: "/technology"

    get "/production/netaudio06-london", Redirector, to: "/articles/3-netaudio-london"
    get "/production/sam-cafe-oto-commission/", Redirector, to: "/articles/1-sam-cafe-oto-commission"

    get "/search/by-tag/production", Redirector, to: "/production"
    get "/search/by-tag/WebDesign", Redirector, to: "/technology"
    get "/search/by-tag/MusicTechnology", Redirector, to: "/technology"

    get "/people/matt-spendlove", Redirector, to: "/articles/4-matt-spendlove"
    get "/people/andi-studer", Redirector, external: "https://archive.cenatus.org/people/andi-studer/"
    get "/people/jenna-jones", Redirector, external: "https://archive.cenatus.org/people/jenna-jones/"
    get "/people/christoph-guttandin", Redirector, external: "https://archive.cenatus.org/people/christoph-guttandin/"
    get "/people/gregor-barth", Redirector, external: "https://archive.cenatus.org/people/gregor-barth/"
    get "/people/luca-schiavoni", Redirector, external: "https://archive.cenatus.org/people/luca-schiavoni/"
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
