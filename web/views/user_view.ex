defmodule MicoseBackend.UserView do
  use MicoseBackend.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, MicoseBackend.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, MicoseBackend.UserView, "user.json")}
  end

  def render("user.json", %{user: nil}) do
    nil
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      pseudo: user.pseudo,
      books: render_many(user.books, MicoseBackend.BookView, "forOwner.json"),
      borrowedBooks: render_many(user.borrowed_books, MicoseBackend.BookView, "forBorrower.json")
    }
  end

  def render("userLight.json", %{user: user}) do
      %{id: user.id,
        pseudo: user.pseudo}
    end
end
