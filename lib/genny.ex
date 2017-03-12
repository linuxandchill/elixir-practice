defmodule Compz do 
  def loop(number) do 
    list = 1..number
    for x <- list, rem(x,2) == 0 do 
      x 
    end 
  end 

  def filtery do
    users = [user: "john", admin: "meg", guest: "barbara"]

    for {type, name} when type != :guest <- users do 
      String.upcase(name)
    end 
  end 
end 
