# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :micose_backend,
  ecto_repos: [MicoseBackend.Repo]

# Configures the endpoint
config :micose_backend, MicoseBackend.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Pgf9CwcNSGBqQqHfvUhOLAgi/OzQbWekoJ05oWsvbqgDhDisAtVUXT/xI5zWYKvA",
  render_errors: [view: MicoseBackend.ErrorView, accepts: ~w(json)],
  pubsub: [name: MicoseBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures ExAdmin
config :ex_admin,
  repo: MicoseBackend.Repo,
  module: MicoseBackend,
  modules: [
    MicoseBackend.ExAdmin.Dashboard,
    MicoseBackend.ExAdmin.Book
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :xain, :after_callback, {Phoenix.HTML, :raw}

