require './game.rb'
require './piece.rb'
require './player.rb'

class Board
  # piece.rb
  # @board[*@current_position]
  # @board[2, 1]

  # [] pos_arr
  # @grid[pos[0]][pos[1]] => @board[[2,1]]
  def [](position)
    @grid[pos[0]][pos[1]]   #
  end

  def initialize
    @grid = Array.new(8) { Array.new(8) }  # nil is immutable

  end

  # black: odd even odd   white: even odd even
  # even : 0, 2, 4, 6     odd: 1, 3, 5, 7
  # row index + col index = odd ? put a piece there

  def populate_board
    grid_design = { red: [0, 1, 2], wht: [5, 6, 7] }

    grid_design.each do |key, val|
      val.each do |row_num|
        if row_num.even?
          [1, 3, 5, 7].each do |col_num|
            @grid[row_num][col_num] = Piece.new(self,[row_num, col_num], key)
          end
        else
          [0, 2, 4, 6].each do |col_num|
            @grid[row_num][col_num] = Piece.new(self,[row_num, col_num], key)
          end
        end
      end
    end
    nil
  end

  def display
    render_string = ""
    @grid.each.with_index do |row, idx1|
      row.each.with_index do |piece, idx2|
        if piece.is_a?(Piece)
          render_string << " #{piece.color} "
        else
          render_string << "  -  "
        end
      end
      render_string << "\n"
    end
    print render_string
  end

  def move_piece(start, finish)
    piece = self[start_pos]
    piece.perform_slide(finish)
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.populate_board
  board.display
end
