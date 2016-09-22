require_relative 'grid'
class A_Star_Pathfinding
	@open_list = []
	@close_list = []
	@path = []

	def self.start(grid)
		grid.display
		exit_node = grid.exit
		cursor = grid.entrance
		steps = []
		while cursor != exit_node
			steps << cursor.node_axis
			cursor = A_Star_Pathfinding.find_next_move(grid, cursor, exit_node)
			grid.display
		end
		steps = steps+[grid.exit.node_axis]
		exit_path = cursor.family_tree(grid.entrance,[]).uniq+[grid.exit.node_axis]
		wall = grid.wall.map{|x| x.node_axis}
		result = {
			grid_dimension: grid.dimension,
			wall: wall,
			entrance: grid.entrance.node_axis,
			exit: grid.exit.node_axis,
			exit_path: exit_path,
			steps: steps
		}
		result
	end	

	def self.find_next_move(grid, cursor, exit_node)
		nodes = A_Star_Pathfinding.adjacent_f_cost(grid, cursor, exit_node)
		move = A_Star_Pathfinding.find_lowest_f_cost(nodes, cursor)
	end

	def self.adjacent_f_cost(grid, cursor, exit_node)
		adjacent_nodes = A_Star_Pathfinding.adjacent_nodes(grid, cursor)
		adjacent_nodes.each do |node|
			if node.parent.nil?
				node.update_h_cost(exit_node.node_axis)
				node.update_g_cost(cursor)
				node.set_parent = cursor
			end
		end
		adjacent_nodes		
	end

	def self.adjacent_nodes(grid, cursor)
		adjacent_nodes = []
		grid.adjacent_nodes(cursor.node_axis[0], cursor.node_axis[1]).each do |node|
			if node.parent == cursor || node.parent.nil?
				adjacent_nodes<<node
			end
		end
		adjacent_nodes
	end

	def self.find_lowest_f_cost(nodes, cursor)
		nodes_scores = []
		nodes.each do |node|
			nodes_scores << node.f_cost
		end
		i = nodes.index {|x| x.f_cost == nodes_scores.sort.first}
		if i
			nodes[i].set_attribute = "close"
			new_move = nodes[i]
		else
			new_move = cursor.parent
		end
		new_move
	end
end