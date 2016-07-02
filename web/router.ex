defmodule MicoseBackend.Router do
  use MicoseBackend.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MicoseBackend do
    pipe_through :api
  end
end
