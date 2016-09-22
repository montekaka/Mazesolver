require_relative 'node'
class Grid
	attr_reader :nodes, :entrance, :exit, :wall, :pathway, :dimension

	def initialize file_directory
		load_maze(file_directory)
		self.setup
	end

	def load_maze file_directory
		@nodes = []
		files = File.readlines(file_directory)
		files.each_with_index do |line, i|
			col = []
			line.chomp.split('').each_with_index do |cell, j|
				if cell == " "
					attribute = nil
				else
					attribute = cell
				end						
				node = Node.new([i,j], attribute)					
				col << node
			end
			@nodes << col
		end
		@dimension = [@nodes.length, @nodes.first.length]
	end

	def setup
		@wall = []
		@pathway = []				
		@nodes.each do |col|
			col.each do |node|
				if node.attribute == "S"
					@entrance = node
				elsif node.attribute == "E"
					@exit = node
				elsif node.attribute == "*"
					@wall << node
				else
					@pathway << node
				end				
			end
		end
	end	

  def [](row, col)
    @nodes[row][col]
  end		

  def adjacent_nodes(row, col)
  	adjacent_nodes = []
  	self[row, col].adjacent_nodes.each do |axis|  		
  		row, col = axis
  		if self.within_range(row, col) && self.allow_to_include(row, col)
  			adjacent_nodes << self[row, col]
  		end  		
  	end
  	adjacent_nodes
  end

  def within_range(row, col)
  	result = false
  	if row.between?(0, @dimension[0]-1) && col.between?(0, @dimension[1]-1) 
  		result = true
  	end
  	result
  end

  def allow_to_include(row, col)
  	result = true
  	if ["close", "*", "S"].include?(self[row, col].attribute)  		
  		result = false
  	end
  	result
  end

  def display
    n = @nodes.first.count-1
    range = (0..n)
    header = []
    range.each do |x|
    	if x < 10
    		header << x.to_s+" "
    	else
    		header << x.to_s
    	end
    end    
    header = header.join("  ")  
    p "  #{header}"	
  	@nodes.each_with_index do |row, i|
  		display_row(row, i)
  	end
  	puts ""
  end

  def display_row(row, i)
  	#row_print = row.map{|x| x.attribute }.join("  ")
  	row_print = []
  	row.each_with_index do |x, j|
  		if x.attribute.nil?
  			col_text = " "
  		elsif x.attribute == "close"
  			col_text = "C"
  		else
  			col_text = x.attribute
  		end
  		row_print << (col_text + " ")	
  	end  	
  	p "#{i} #{row_print.join('  ')}"    
  end
end