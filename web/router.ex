defmodule CheckpandaServer.Router do
  use CheckpandaServer.Web, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", CheckpandaServer do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
  end

  scope "/users", UserController do
    pipe_through(:api)

    get("/", UserController, [])
  end

  # Other scopes may use custom stacks.
  # scope "/api", CheckpandaServer do
  #   pipe_through :api
  # end
end
