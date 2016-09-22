require_relative 'grid'
require_relative 'a_star_pathfinding'
class Maze
	attr_reader :grid

	DISPLAY_MARK = {
		:nil    => " ",
		:wall  => "*",
		:start => "S",
		:exit  => "E"
	}

	def initialize grid_file
		@grid = Grid.new(grid_file)
	end

	def start
		A_Star_Pathfinding.start(grid)
	end

end