NORMAL_DIR = { red: [[1,1], [1,-1]], wht: [[-1,1], [-1,-1]] }
KILLING_DIR = { red: [[2,2], [2, -2]], wht: [[-2,2], [-2,-2]] }

require 'byebug'
class Piece
  attr_reader :color

  def initialize(board, position, color, king = false)
    @board = board
    @current_position = position
    @color = color
    @king = king
  end

  # call a valid moves
  def perform_slide(finish)
    valid_moves

  end

  def perform_jump

  end

  # possible and legal moves
  def valid_moves
    row = @current_position[0]
    col = @current_position[1]
    result = []
    dir_arr = direction
    dir_arr.each.with_index do |direction|
      next_move = [row + direction[0], col + direction[1]]
      result << next_move if on_board?(next_move)
    end
    result
  end

  def on_board?(pos)
    row, col = pos[0], pos[1]
    if row >= 0 && row <= 7
      if col >= 0 && col <= 7
        return true
      end
    end
    false
  end

  def direction
    possible_moves = NORMAL_DIR[@color] + KILLING_DIR[@color]
    
  end

end

piece = Piece.new(nil, [3, 3], :wht)
p piece.valid_moves
