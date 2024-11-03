defmodule UsersServicePhoenix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      UsersServicePhoenixWeb.Telemetry,
      UsersServicePhoenix.Repo,
      {DNSCluster, query: Application.get_env(:users_service_phoenix, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: UsersServicePhoenix.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: UsersServicePhoenix.Finch},
      # Start a worker by calling: UsersServicePhoenix.Worker.start_link(arg)
      # {UsersServicePhoenix.Worker, arg},
      # Start to serve requests, typically the last entry
      UsersServicePhoenixWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UsersServicePhoenix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UsersServicePhoenixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
