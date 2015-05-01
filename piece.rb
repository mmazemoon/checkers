

class Piece

SLIDING_DIR = { red: [[1,1], [1,-1]], wht: [[-1,1], [-1,-1]] }
JUMPING_DIR = { red: [[2,2], [2, -2]], wht: [[-2,2], [-2,-2]] }

  attr_reader :color, :current_position

  def initialize(board, position, color, king = false)
    @board = board
    @current_position = position
    @color = color
    @king = king
  end

  def direction(array)
    row = @current_position[0]
    col = @current_position[1]
    result = []
    array.each do |direction|
      next_move = [row + direction[0], col + direction[1]]
      result << next_move if on_board?(next_move)
    end
    result
  end

  def jumps
    jumps_dir = JUMPING_DIR[@color]
    in_range_jumps = direction(jumps_dir)
    in_range_jumps.select do |move|
      so_called_enemy = midpoint(move)
      if @board[so_called_enemy].nil? || @board[move].is_a?(Piece)
        false
      elsif @board[so_called_enemy].color == @color
        false
      else
        true
      end
    end
  end

  def midpoint(move)
    row = (@current_position[0] + move[0]) / 2
    column = (@current_position[1] + move[1]) / 2
    [row, column]
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


  def perform_slide!(finish)
    @board[@current_position]= nil
    @current_position = finish
    @board[@current_position]= self
  end

  def perform_jump!(finish)
    enemy_pos = midpoint(finish)
    @board[enemy_pos] = nil
    perform_slide!(finish)
  end

  def slides
    slide_dir = SLIDING_DIR[@color]
    in_range_slides = direction(slide_dir)
    in_range_slides.select do |move|
      @board[move].nil?
    end
  end

  # possible and legal moves
  def valid_moves
    final_result = slides + jumps
  end

end
