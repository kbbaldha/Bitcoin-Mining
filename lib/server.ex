defmodule Server do
use GenServer do
def fun1
    IO.puts "callback"
end
end