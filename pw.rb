
class Cat

  attr_accessor :winner, :loser

  def initialize(node, orientation, board)
    @node = node
    @coordinates = node.coordinates
    @orientation = orientation
    @board = board
    @winner = false
    @loser = false
  end

  def rotate(direction)
    if direction == :left
      if @orientation == 1
        @orientation = 4
      else
        @orientation -= 1
      end
    end

    if direction == :right
      if @orientation == 4
        @orientation = 1
      else
        @orientation += 1
      end
    end
  end

  def walk

    @node.cat = nil
    if @orientation == 1 && @coordinates.last != @board.width-1 && @node.node_to_right.cat == nil
      @node = @node.node_to_right
    elsif @orientation == 2 && @coordinates.first != @board.height-1 && @node.node_below.cat == nil
      @node = @node.node_below
    elsif @orientation == 3 && @coordinates.last != 0 && @node.node_to_left.cat == nil
      @node = @node.node_to_left
    elsif @orientation == 4 && @coordinates.first != 0 && @node.node_above.cat == nil
      @node = @node.node_above
    end

    @coordinates = @node.coordinates
    @node.cat = self

  end

  def attack
    if @orientation == 1 && @coordinates.last != @board.width-1
      if @node.node_to_right.cat != nil
         @node.node_to_right.cat.loser = true
         @node.node_to_right.cat = nil
         self.winner = true
      end
      if @node.node_to_right.node_to_right != nil && @node.node_to_right.node_to_right.cat != nil
         @node.node_to_right.node_to_right.cat.loser = true
         @node.node_to_right.node_to_right.cat = nil
         self.winner = true
      end
    elsif @orientation == 2 && @coordinates.first != @board.height-1
      if @node.node_below.cat != nil
         @node.node_below.cat.loser = true
         @node.node_below.cat = nil
         self.winner = true
      end
      if @node.node_below.node_below != nil && @node.node_below.node_below.cat != nil
         @node.node_below.node_below.cat.loser = true
         @node.node_below.node_below.cat = nil
         self.winner = true
      end
    elsif @orientation == 3 && @coordinates.last != 0
      if @node.node_to_left.cat != nil
         @node.node_to_left.cat.loser = true
         @node.node_to_left.cat = nil
         self.winner = true
      end
      if @node.node_to_left.node_to_left != nil && @node.node_to_left.node_to_left.cat != nil
         @node.node_to_left.node_to_left.cat.loser = true
         @node.node_to_left.node_to_left.cat = nil
         self.winner = true
      end
    elsif @orientation == 4 && @coordinates.first != 0
      if @node.node_above.cat != nil
         @node.node_above.cat.loser = true
         @node.node_above.cat = nil
         self.winner = true
      end
      if @node.node_above.node_above != nil && @node.node_above.node_above.cat != nil
         @node.node_above.node_above.cat.loster = true
         @node.node_above.node_above.cat = nil
         self.winner = true
      end
    end
  end

  def sleep
  end




end

class Node
  
  attr_accessor :contains_cat, :cat
  attr_reader :coordinates

  def initialize(coordinates, board)
    @board = board
    @coordinates = coordinates
    @cat = nil
  end

  def node_to_right
    @board.board[@coordinates.first][@coordinates.last + 1]
  end

  def node_below
    @board.board[@coordinates.first + 1][@coordinates.last]
  end

  def node_to_left
    @board.board[@coordinates.first][@coordinates.last - 1]
  end

  def node_above
    @board.board[@coordinates.first - 1][@coordinates.last]
  end

end

class Board

  attr_reader :board, :width, :height, :cat1, :cat2

  def initialize(width, height)
    @width = width
    @height = height
    create_board
    initialize_cats
  end

  def create_board
    @board = Array.new(@height) {|array| array = Array.new}
    @board.each_with_index do |row, x_coordinate|
      @width.times do |y_coordinate|
        row << Node.new([x_coordinate, y_coordinate], self)
      end
    end
  
  end

  def initialize_cats
    @cat1 = Cat.new(@board[1][0], 1, self)
    @board[1][0].cat = @cat1
    @cat2 = Cat.new(@board[1][4], 1, self)
    @board[1][4].cat = @cat2
  end

  def print_board
    @board.each do |row|
      row.each do |node|
        if node.cat == nil
          print " "
        else
          print "@"
        end
        print "|"
      end
      puts ""
    end
  end

  def victory?
    if (@cat1.loser == true && @cat2.winner == true) || (@cat1.winner == true && @cat2.loser == true)
      return true
    end

    return false

end


gameboard = Board.new(5, 3)
gameboard.print_board
puts ""
gameboard.cat1.walk
gameboard.print_board
puts ""
gameboard.cat1.walk
gameboard.print_board
puts ""
gameboard.cat1.walk
gameboard.print_board
puts ""
gameboard.cat1.walk
gameboard.print_board
puts ""
gameboard.cat1.rotate(:right)
gameboard.cat1.walk
gameboard.print_board
puts ""
gameboard.cat1.rotate(:left)
gameboard.cat1.walk
gameboard.print_board
puts ""
gameboard.cat1.rotate(:left)
gameboard.cat1.attack
gameboard.print_board
puts ""


