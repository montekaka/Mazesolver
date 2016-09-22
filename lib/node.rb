class Node
	attr_reader :f_cost, :g_cost, :h_cost, :node_axis, :attribute, :parent
	Adjacent_Nodes = [
		[1,0],
		[1,1],
		[0,1],
		[0,-1],
		[-1,-1],
		[1,-1],
		[-1,1],
		[-1,0]
	]

	def initialize node_axis, attribute
		@node_axis = node_axis
		@attribute = attribute
	end

	def update_h_cost(exit_axis)
		x_node, y_node = @node_axis
		x_exit, y_exit = exit_axis
		x_midpoint = x_node
		y_midpoint = y_exit	
		d_one_square = (x_node - x_midpoint)**2 + (y_node - y_midpoint) ** 2 
		d_two_square = (x_exit - x_midpoint)**2 + (y_exit - y_midpoint) ** 2 
		@h_cost = (Math.sqrt(d_one_square) + Math.sqrt(d_two_square)) * 10
	end

	def calculate_g_cost(current_node)
		x_node, y_node = @node_axis
		x_exit, y_exit = current_node.node_axis	
		d_one_square = (x_node*1.0 - x_exit*1.0)**2.0 + (y_node*1.0 - y_exit*1.0) ** 2.0
		(Math.sqrt(d_one_square)*10.0).to_i+current_node.g_cost.to_i
	end

	def update_g_cost current_node		
		@g_cost = self.calculate_g_cost(current_node)
		@f_cost = @g_cost.to_i + @h_cost.to_i
	end

	def adjacent_nodes
		adjacent_nodes = []
		Adjacent_Nodes.each do |adjacent_node|
			adjacent_nodes << self.add_node(adjacent_node)
		end	
		adjacent_nodes
	end

	def add_node adjacent_node
		node = []
		self.node_axis.each_with_index do |x,i|
			node << (x + adjacent_node[i])
		end
		node
	end

	def set_attribute= param
		@attribute = param
	end

	def set_parent= parent
		if @parent.nil?
			@parent = parent
		end
	end

	def family_tree(parent_node, exit_path)
		node = self
		if node.parent == parent_node
			parent_node = node
		else			
			node = node.parent
			node.family_tree(parent_node, exit_path)			
		end
		exit_path << node.node_axis
	end
end