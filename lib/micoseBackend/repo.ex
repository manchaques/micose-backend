defmodule MicoseBackend.Repo do
  use Ecto.Repo, otp_app: :micoseBackend
  use Scrivener, page_size: 10
end
