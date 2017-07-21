defmodule Ticker do

  @interval 2000 # 2 seconds
  @name :ticker

  def start() do
    pid = spawn(__MODULE__, :generator, [[], nil])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send(:global.whereis_name(@name), {:register, client_pid})
  end

  def generator(clients, current_client) do
    receive do
      {:register, pid} ->
        IO.puts("Registering #{inspect(pid)}")

        if current_client == nil do
          current_client = 0
        end

        generator([pid | clients], current_client)
    after
        @interval ->
          IO.puts("Tick")

          if current_client != nil do
            client = Enum.at(clients, current_client)
            send(client, {:tick})
            current_client = current_client + 1

            if length(clients) > current_client do
              current_client = 0
            end
          end

          generator(clients, current_client)
    end
  end
end


defmodule Client do

  def start() do
    pid = spawn(__MODULE__, :receiver, [])
    Ticker.register(pid)
  end

  def receiver() do
    receive do
      {:tick} ->
        IO.puts("Tock in client")
        receiver()
    end
  end
end
