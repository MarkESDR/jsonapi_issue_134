# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :jsonapi_issue_134,
  ecto_repos: [JsonapiIssue134.Repo]

# Configures the endpoint
config :jsonapi_issue_134, JsonapiIssue134Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bzB8me2uB1kP5NEPt8i0QMiQPz0gsuw7PQjO2Fuhiyjvd2AeT/pzETiE4TYxEKHK",
  render_errors: [view: JsonapiIssue134Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: JsonapiIssue134.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
