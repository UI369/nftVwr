# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :nftVwr,
  ecto_repos: [NftVwr.Repo]

# Configures the endpoint
config :nftVwr, NftVwrWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "AXliZf0v+BKdnTXxINjr/wOngOWiEGmPOU4neCc4cEy6CldxLMOY0gEguMC6qUfH",
  render_errors: [view: NftVwrWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: NftVwr.PubSub,
  live_view: [signing_salt: "8sdDsxJI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
