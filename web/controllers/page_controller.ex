defmodule Elph.PageController do
  use Elph.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  @doc """
  Sends back the channel ID, as acknowledge that we've created the channel
  """
  def create_channel(conn, %{"my_uuid" => his_uuid}) do
    channel_id = "conversation:" <> his_uuid
    render conn, "create_channel.json", channel_id: channel_id
  end

  def redirect_to_elph(conn, _params) do
    redirect conn, to: "/elph"
  end
end
