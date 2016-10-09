defmodule TourGuide.Router do
  use TourGuide.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug TourGuide.Auth, repo: TourGuide.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TourGuide do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/sign-up", UserController, :new
    post "/sign-up", UserController, :create

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/guides", TourGuideController, only: [:index, :new, :create, :update]
    get "/guides/edit", TourGuideController, :edit

    resources "/tour", TourController

    resources "/tours", TourInstanceController, except: [:new]
    get "/tours/:id/activate", TourInstanceController, :new
  end

  scope "/admin", TourGuide do
    pipe_through :browser # TODO: Add admin checks here!

    resources "/categories", CategoryController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TourGuide do
  #   pipe_through :api
  # end
end
