use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :jsonapi_issue_134, JsonapiIssue134Web.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :jsonapi_issue_134, JsonapiIssue134.Repo,
  username: "postgres",
  password: "postgres",
  database: "jsonapi_issue_134_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
