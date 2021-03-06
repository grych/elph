# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elph, Elph.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "xIOK6V6V4eEKZgaZBu9DhcVjoRO4E3VFFsMVKiBc+HzaXi/+ym0muKDTCDYHN18P",
  render_errors: [view: Elph.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Elph.PubSub,
           adapter: Phoenix.PubSub.PG2],
  static_url: [path: "/elph"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
