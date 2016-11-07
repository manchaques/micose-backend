defmodule MicoseBackend.BookControllerSpec do
  use ESpec.Phoenix, controller: MicoseBackend.BookController, async: true
  use TestThatJson.ESpec


  describe "as a unlogged user" do
    let :owner, do: insert_user(pseudo: "owner")
    let :book, do: insert_book(title: "book", owner: owner)
#    let! :user_video, do: insert_video(user, title: "funny cats")
#    let! :other_video, do: insert_video(insert_user(username: "other"), title: "another video")

    let :response do
      build_conn
      |> get(book_path(build_conn, :index))
    end

    it "I can list all books" do
       json_response = response |> json_response(200)

       json_response |> should(have_key "data")

       json_response
         |> Map.fetch!("data")
         |> should(have_size 0)
    end
  end
end