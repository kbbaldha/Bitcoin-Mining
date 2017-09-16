defmodule Testclient do


  # def main(args) do
  #   args |> parse_args |> process
  # # end

  # def process([]) do
  #   IO.puts "No arguments given"
  # end

  # def process(options) do
  #   IO.puts "Hello #{options[:name]}"
  #   c = options[:name]
  #   Example.coingenerator(c)
  # end

  # defp parse_args(args) do
  #   {options, _, _} = OptionParser.parse(args,
  #     switches: [name: :integer]
  #   )
  #   options
  # end

    


   
  def main(args) do
    #Task.start_link(fn -> loop(%{}) end)
   # parent = self()
    #Task.start_link(fn -> sendMsg(parent) end)
    args |> parse_args
    
  end

  defp parse_args(args) do
     {options, _, _} = OptionParser.parse(args,
       switches: [name: :string]
     )
     #IO.puts "#{options[:name]}"
     
      options
      IO.puts("hello")
      k = "one@" <> to_string options[:name]
      Node.start(String.to_atom(k))
      
     Node.self |> IO.puts
     Node.get_cookie |> IO.puts
     Node.set_cookie :"choco"
     Node.get_cookie |> IO.puts
     Node.connect(:"two@192.168.0.147") 
     get_str_from_server()
   end

  def get_str_from_server do
  #IO.puts "helooooooooooooooo"
    {:news,str,size} = GenServer.call({:chat_room,:"two@192.168.0.147"},{:print_message,"karan"})
    {:p_val,ret,hashed} = process_sha_256(str,size)  
    if(ret == "") do
      #GenServer.cast({:chat_room,:"karan@192.168.0.147"},{:print_answer,""})
    else 
      IO.puts "Found coin : "<>str
      GenServer.cast({:chat_room,:"two@192.168.0.147"},{:print_answer,{:p_val,ret,hashed}})
    end

    get_str_from_server()
  end

  def process_sha_256(str,l) do
    hashed = :crypto.hash(:sha256,str) |> Base.encode16
    
    #IO.puts "#{hashed}"
    substr = String.slice hashed, 0..l-1
    #IO.puts "#{substr}"
    substr_chck = String.duplicate("0",l)
    #IO.puts "#{substr_chck}"
    if substr == substr_chck do
      IO.puts "#{str}" 
      IO.puts "#{hashed}" 
      IO.puts "hello" 
      :timer.sleep(1000)
      {:p_val,str,hashed}
    else
      {:p_val,"",""}
    end
  

  end


  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end

  def sendMsg caller,msg do    
    send caller,{:ok, msg}
    send caller,{:another, "another "<>msg}
  end

  def readMsg do
    
    receive do      
      {:ok,msg} -> "received msg :: #{msg}"
        IO.puts "msg received as #{msg}"
      {:another,msg} -> "received msg :: #{msg}"
        IO.puts "#{msg} #{Node.self}"
    end
    readMsg()
  end

  

end


# Node.spawn_link :"karan@192.168.0.147", fn -> Example.add(2,3) end
# {:ok, msgReader} = Task.start_link(fn -> KV.readMsg end)
# iex --name "keyur@192.168.0.173" --cookie choco -S mix
# pid = Node.spawn_link(:"keyur@192.168.0.173",KV, :readMsg, [])
# send pid, {:another, "yes"}
