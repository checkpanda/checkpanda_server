use Mix.Config

import_config "./common.exs"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :checkpanda_server, CheckpandaServer.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :checkpanda_server, CheckpandaServer.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "panda",
  password: "panda",
  database: "checkpanda_server_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
