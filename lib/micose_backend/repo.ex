defmodule MicoseBackend.Repo do
  use Ecto.Repo, otp_app: :micose_backend
  use Scrivener, page_size: 10
end
