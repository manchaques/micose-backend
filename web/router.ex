defmodule MicoseBackend.Router do
  use MicoseBackend.Web, :router

  use ExAdmin.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MicoseBackend do
    pipe_through :api
    resources "/books", BookController, except: [:new, :edit]
    resources "/comics", ComicsController, except: [:new, :edit]
    resources "/mangas", MangaController, except: [:new, :edit]
    resources "/users", UserController, except: [:new, :edit]
    resources "/book_collections", Book_CollectionController, except: [:new, :edit]
    resources "/classifications", ClassificationController, except: [:new, :edit]
    resources "/tags", TagController, except: [:new, :edit]
    resources "/communities", CommunityController, except: [:new, :edit]
    get "/book/find", BookController, :findByTag
  end

  scope "/admin", ExAdmin do
    pipe_through :browser
    admin_routes
   end
end
