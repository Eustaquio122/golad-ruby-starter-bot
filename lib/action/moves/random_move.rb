class RandomMove
  MOVES = %w(birth kill pass)

  def new_move(my_id, op_id, board)
    @board = board
    @my_cells, @op_cells, @empty_cells = get_cells(my_id, op_id) # gets three arrays with coordinates of player cells, opponent cells, and empty cells
    move = @my_cells.length >= 2 ? MOVES.sample : MOVES[1..-1].sample # chooses a random move from MOVE array if player cells >= 2, chooses a random move between 'kill' and 'pass' otherwise
    send(move) # calls method with randomly selected name from MOVES array
  end

  def kill # returns 'kill' instruction with the coordinates of a random opponent cell
    ['kill', @op_cells.sample]
  end

  def birth # returns 'birth' with two own random cells to sacrifice
    @my_cells.shuffle!
    ['birth', @empty_cells.sample, @my_cells.shift, @my_cells.shift]
  end

  def pass
    ['pass']
  end

  def get_cells(my_id, op_id)
    [filter_cells(my_id), filter_cells(op_id), filter_cells('.')]
  end

  def filter_cells(id) # finds cells that match an id and returns string with coordinates in the right output order
    cells = []
    @board.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        cells << "#{x},#{y}" if cell == id
      end
    end
    cells
  end
end
