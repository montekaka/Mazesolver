require 'json'
require './maze.rb'
maze = Maze.new('./maze.txt')
exit_node = maze.start

File.open("../result/result.json","w") do |f|
  f.write(exit_node.to_json)
end