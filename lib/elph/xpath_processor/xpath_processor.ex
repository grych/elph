defmodule Elph.XpathProcessor do
  import SweetXml
  require IEx

  defmodule Input do
    defstruct xml: nil, xpath: nil, xpath_modifiers: nil
  end

  defmodule Output do
    defstruct status: :unknown, output: nil
  end

  def start_link(input, computing_ref, owner) do 
    Task.start_link(__MODULE__, :fetch, [input, computing_ref, owner])
  end

  def fetch(%Elph.XpathProcessor.Input{xml: xml, xpath: x, xpath_modifiers: xpath_modifiers}, computing_ref, owner) do
    xml
    |> xpath(sigil_x(x, String.to_char_list(xpath_modifiers)))
    |> send_results(computing_ref, owner)
  end

  defp send_results(answer, computing_ref, owner) do
    result = %Output{status: :ok, output: answer}
    # send it back to the owner
    send(owner, {:results, computing_ref, result})
  end



  def compute(input) do
    computing_ref = make_ref()
    # input = %Input{xml: xml, xpath: xpath, xpath_modifiers: xpath_modifiers}
    {:ok, pid} = Supervisor.start_child(Elph.XpathProcessor.Supervisor, [input, computing_ref, self()])
    monitor_ref = Process.monitor(pid)

    timeout = 5000
    timer = Process.send_after(pid, :timedout, timeout) 

    receive do
      {:results, ^computing_ref, results} ->
        # demonitor with flush - the :DOWN message is removed from the queue
        Process.demonitor(monitor_ref, [:flush])
        {:ok, results}
      # :DOWN message comes from monitor
      {:DOWN, ^monitor_ref, :process, ^pid, reason} -> 
        # let it crash
        reason # {:fatal, why it creashed...}
      :timedout ->
        kill(pid, monitor_ref) 
        cleanup(timer)
        :timeout
    after
      timeout ->
        kill(pid, monitor_ref)
        cleanup(timer)
        :timeout
    end 
    
  end

  defp kill(pid, ref) do 
    Process.demonitor(ref, [:flush]) 
    Process.exit(pid, :kill)
  end

  defp cleanup(timer) do
    :erlang.cancel_timer(timer) 
    receive do
      :timedout -> :ok 
    after
      0 -> :ok end
  end

end
