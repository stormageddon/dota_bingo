class Tile
	@@tileCoord = []
	@@tileValue = ""
	
	def initialize(coords,value)
		@@tileCoord = coords
		@@tileValue = value
	end
	
	def get_tile_value()
		@@tileValue
	end
	
	def get_tile_coords()
		@@tileCoord
	end
end

# A board will consist of 25 tiles
#   in a 5x5 pattern. The center tile
#   will be a Free square
class Board
	@@boardTiles
	
	def initialize()
		@@boardTiles = Hash.new
	end
	
	def create_and_add_new_tile(tileCoord, tileValue)
		@@boardTiles[tileCoord] = tileValue
	end
	
	def add_tile(tile)
		@@boardTiles[tile.get_tile_coords()] = tile.get_tile_value()
	end
	
	def print_tile_at_coord(coord)
		puts @@boardTiles.fetch(coord)
	end
	
	def print_board()
		for x in 0..4
			currRow = "| "
			for y in 0..4
				currRow += " #{@@boardTiles.fetch([x,y])} |"
			end
			puts "#{currRow.to_s} \n\n"
		end
	end
	
	def size()
		@@boardTiles.size()
	end
	
end

class Game
	@@board = Board.new
	
	def initialize()
		path = "options.txt"
		options = read_options(path)
		@@board = generate_board(options)
	end
	
	def read_options(filePath)
		optionsArray = []
		File.read(filePath).each_line do |line|
			optionsArray.push(line.chomp.center(70))
		end
		
		return optionsArray	
	end
	
	def generate_board(tileData) 
		x = 0
		y = 0
		r = Random.new
		for i in 0..24 do
			index = r.rand(tileData.length)
			tile = Tile.new([x,y],tileData[index])
			tileData.delete_at(index)
			@@board.add_tile(tile)
			y += 1
			if y == 5
				y = 0
				x += 1
			end
			if x == 5
				return @@board
			end
		end
		return @@board
	end
	
	def get_board()
		return @@board
	end
end
game = Game.new
game.get_board().print_board()