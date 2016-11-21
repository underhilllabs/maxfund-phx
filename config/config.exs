# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :maxfund,
  ecto_repos: [Maxfund.Repo]

# Configures the endpoint
config :maxfund, Maxfund.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Fl9XvAlxnGjhHyCF6CGz10rnKp+XA7jY/0xyZzVD2uOKzWkb/6OfQHw5OdFl1sAS",
  render_errors: [view: Maxfund.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Maxfund.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configure guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "Unicorn",
  ttl: { 30, :days },
  verify_issuer: true, # optional
  secret_key: "GFirMsmChzWa36UMMLrOtnquifGm+yF4eHpjL7Po2IoIN8jOTaGKD+dIknVFYZ8h",
  serializer: Bookmarks.GuardianSerializer


# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
