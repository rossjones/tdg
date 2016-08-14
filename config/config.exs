# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :testdatagen,
  namespace: TDG,
  ecto_repos: [TDG.Repo]

# Configures the endpoint
config :testdatagen, TDG.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "a1d7nc00rSeLGpEc6/DZSxixJFPTMPnnGT7bHmvijd5veo9h7Cy7+dVZX36tn598",
  render_errors: [view: TDG.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TDG.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
