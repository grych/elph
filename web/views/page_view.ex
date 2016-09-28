defmodule Elph.PageView do
  use Elph.Web, :view

  def render("create_channel.json", %{channel_id: channel_id}) do
    %{
      status: :ok,
      channel_id: channel_id
    }
  end
end
