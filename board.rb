class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) }  # nil is immutable

  end

  # black: odd even odd   white: even odd even
  # even : 0, 2, 4, 6     odd: 1, 3, 5, 7
  # row index + col index = odd ? put a piece there

  def populate_board
    grid_design = { red: [0, 1, 2], white: [5, 6, 7] }

    grid_design.each do |key, val|
      val.each do |row_num|
        if row_num.even?
          [1, 3, 5, 7].each do |odd_col|
            @grid[row_num][col_num] = Piece.new(self,[row_num, odd_col], key)
          end
        else
          [0, 2, 4, 6].each do |even_col|
            @grid[row_num][odd_col] = Piece.new(self,[row_num, odd_col], key)
          end
        end
    nil
  end



end
