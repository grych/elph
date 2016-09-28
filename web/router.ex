defmodule Elph.Router do
  use Elph.Web, :router

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

  scope "/", Elph do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    # get "/update", PageController, :update
    get "/create_channel", PageController, :create_channel
  end

  # Other scopes may use custom stacks.
  # scope "/api", Elph do
  #   pipe_through :api
  # end
end