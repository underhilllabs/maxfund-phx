defmodule Maxfund.Router do
  use Maxfund.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Maxfund.Auth, repo: Maxfund.Repo 
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Maxfund do
    pipe_through :browser # Use the default browser stack

    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/cats", CatController, only: [:index, :show]

    get "/", CatController, :index
  end

  scope "/admin", Maxfund do
    pipe_through :browser # Use the default browser stack

    resources "/cats", CatController

    get "/", CatController, :index
  end
    

  # Other scopes may use custom stacks.
  # scope "/api", Maxfund do
  #   pipe_through :api
  # end
end
