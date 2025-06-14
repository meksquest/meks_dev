defmodule MeksDev.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MeksDevWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:meks_dev, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MeksDev.PubSub},
      # Start a worker by calling: MeksDev.Worker.start_link(arg)
      # {MeksDev.Worker, arg},
      # Start to serve requests, typically the last entry
      MeksDevWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MeksDev.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MeksDevWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
