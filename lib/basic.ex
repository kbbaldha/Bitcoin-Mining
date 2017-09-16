defmodule Basic do

use GenServer

def start_link do
    GenServer.start_link(__MODULE__,[])
end

def init(init_state) do
    IO.puts "init called" 
    {:ok,init_state}
end

def print_multiple_times(msg, n) when n <= 1 do
    IO.puts msg
  end

  def print_multiple_times(msg, n) do
    #IO.puts msg
    msg = msg<>"k"
    print_multiple_times(msg, n - 1)
  end

def get_my_state(pid) do

    GenServer.call(pid,{:get_state})
end



def handle_call({:get_state}, _from, my_state) do
    
    {:reply,my_state,["keyur"|my_state]}
    
end


end 


