defmodule Elph do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(Elph.Endpoint, []),
      supervisor(Elph.XpathProcessor.Supervisor, [])
    ]

    opts = [strategy: :one_for_one, name: Elph.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    Elph.Endpoint.config_change(changed, removed)
    :ok
  end
end
