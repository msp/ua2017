use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cenatus_ltd, CenatusLtd.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :cenatus_ltd, CenatusLtd.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "cenatus-test",
  database: "ua2017_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

config :extwitter, :oauth, [
   consumer_key: "foo",
   consumer_secret: "bar",
   access_token: "baz",
   access_token_secret: "qux"
]

config :elixirfm,
   api_key: "foo",
   secret_key: "bar"
