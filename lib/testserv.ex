defmodule Testserver do use GenServer
def main(args) do
args |> parse_args
end
defp parse_args([]) do
IO.puts "No arguments given"
end


def start_link(k) do

GenServer.start_link(__MODULE__, k, name: :chat_room)
  end

defp parse_args(args) do

{_, [k], _} = OptionParser.parse(args)
#IO.puts "#{options[:name]}"
k = String.to_integer(k)
IO.puts "helooooooooooooo"
IO.puts "helooooooooooooo #{k}"
#Node.start(:"two@192.168.0.147")
#Node.set_cookie :"choco"
start_link(k)
#GenServer.start_link(__MODULE__, k, name: :chat_room)
#get_str_from_server()
#IO.puts pid1
#pid2 = spawn(__MODULE__,:get_str_from_server,[])
#IO.puts pid2
#pid3 = spawn(__MODULE__,:get_str_from_server,[])
#IO.puts pid3
#get_str_from_server()
end

def add_message(message) do
GenServer.cast(:chat_room, {:add_message, message})
end
def slice(message) do
GenServer.call(:chat_room, {:slice_message, message})
end
def print_message(message) do
GenServer.call(:chat_room, {:print_message, message})
end
def print_answer(message) do
GenServer.cast(:chat_room, {:print_answer, message})
end

def get_messages do
GenServer.call(:chat_room, :get_messages)
end


#   def get_str_from_server do
#     {:news,str,size} = GenServer.call(:chat_room,{:print_message,"karan"})
#     {:p_val,ret,hashed} = process_sha_256(str,size)  
#     if(ret == "") do
#       #GenServer.cast({:chat_room,:"karan@192.168.0.147"},{:print_answer,""})
#     else 
#       IO.puts "str <> hashed"
#       GenServer.cast(:chat_room,{:print_answer,{:p_val,ret,hashed}})
#     end
#     get_str_from_server()
#   end


#     def process_sha_256(str,l) do
#     hashed = :crypto.hash(:sha256,str) |> Base.encode16
#     
#     #IO.puts "#{hashed}"]
#     substr = String.slice hashed, 0..l-1
#     #IO.puts "#{substr}"
#     substr_chck = String.duplicate("0",l)
#     #IO.puts "#{substr_chck}"
#     if substr == substr_chck do
#       #IO.puts "#{str}" 
#       #IO.puts "#{hashed}" 
#       #IO.puts "hello" 
#       :timer.sleep(1000)
#       {:p_val,str,hashed}
#     else
#       {:p_val,"",""}
#     end
# end 
# SERVER
def init(count) do
{:ok, count}
end


def handle_cast({:add_message ,new_message}, messages) do
{:noreply, [new_message | messages]}
end

def handle_call({:print_message ,new_message}, _from,messages) do
#IO.puts " Executed #{new_message} at #{Node.self}  "
# x = Enum.to_list(0..9)
# y = for n <- ?a..?z, do: << n :: utf8 >>
# z = x++y
# cg = Enum.join(Enum.shuffle(z))
# len = Enum.random(Enum.concat([5..15]))
# cg_sub = String.slice cg, 0..len 
# cg_str = "karanacharekar;"<>cg_sub
length=20
cg_sub = :crypto.strong_rand_bytes(length) |> Base.encode64 |> binary_part(0, 20)
cg_str = "karanacharekar;"<> cg_sub
{:reply, {:news, cg_str,messages}, messages}
end

def handle_cast({:print_answer ,new_message},messages) do
{:p_val,a,b} = new_message
IO.puts " #{a} #{b}"
{:noreply, messages}
end

def handle_call(:get_messages, _from, messages) do
{:reply, messages, messages}
end

def handle_call({:slice_message,new_message}, _from, messages) do
new = String.slice new_message , 0..3
{:reply, new, messages}
end
end