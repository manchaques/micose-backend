# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :micoseBackend, MicoseBackend.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "paTDgtAEKTa17cfXWaOei21Y3EPxRG6yEVZIqeD6/+gRkVYB7u7u+hQy2KIeizeJ",
  render_errors: [accepts: ~w(json)],
  pubsub: [name: MicoseBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: false,
  binary_id: true

# Configure ex_admin
config :ex_admin,
  repo: MicoseBackend.Repo,
  module: MicoseBackend,
  modules: [
     MicoseBackend.ExAdmin.Dashboard,
     MicoseBackend.ExAdmin.Book
  ]
config :xain, :after_callback, {Phoenix.HTML, :raw}

