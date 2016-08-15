defmodule TDG.Router do
  use TDG.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TDG do
    pipe_through :browser # Use the default browser stack

    resources "/sessions", SessionController
    get "/generate/:name", GeneratorController, :generate
    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TDG do
  #   pipe_through :api
  # end
end
