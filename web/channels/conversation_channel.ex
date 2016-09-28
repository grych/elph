defmodule Elph.ConversationChannel do
  use Elph.Web, :channel
  require IEx

  @doc """
  Joins the conversation. Notice that the conversation name comes from the client, as his UUID.
  This allows us to create a websocket for every single connected client.
  In this case it is just an example - it is overkill, as we resend the message in this function. We even don't
  need his UUID
  """
  def join("conversation:" <> _his_uuid, payload, socket) do
    if authorized?(payload) do
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  def handle_in("compute_xpath", %{"xpath" => xpath, "xpath_modifiers" => xpath_modifiers, "xml" => xml}, socket) do
    input = %Elph.XpathProcessor.Input{xml: xml, xpath: xpath, xpath_modifiers: xpath_modifiers}
    
    ret_string = case Elph.XpathProcessor.compute(input) do
      # normal case, everything just works; recursively remove 10th element from :xmlElement tuple, as it 
      # contains path
      {:ok, output} -> output.output |> without_path
      # fatal is the error in XML
      {:fatal, error_description} -> error_description
      # badmatch is the sytax error in xpath string
      {{:badmatch, error_description}, _} -> error_description
      :timeout -> "Timeout"
      _ -> "Unknown error, sorry."
    end

    response = %{"status" => "ok", "output" => inspect(ret_string, pretty: true, width: 60)}
    # send the text response back - JS will display it in #output
    broadcast socket, "compute_xpath_response", response
    {:noreply, socket}
  end

  @doc """
  Removes the path from the sweet_xml output. I consider it not safe to show it
  """
  def without_path([{:xmlElement, _, _, _, _, _, _, _, _, _, _, _} = xml_element | tail]) do
    [without_path(xml_element)] ++ without_path(tail)
  end
  def without_path({:xmlElement, _, _, _, _, _, _, _, _, _, _, _} = xml_element) do
    put_elem(xml_element, 10, :hidden)
  end
  def without_path(everything_else) do
    everything_else
  end

  defp authorized?(_payload) do
    true
  end
end
