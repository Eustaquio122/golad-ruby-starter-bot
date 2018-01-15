class Action
  def initialize
    @random = RandomMove.new
    @clock = Clock.new
  end

  def new_action(timebank, info)
    update_info(timebank, info) # stores all required info locally
    make_move 
  end

  private

  def update_info(timebank, info)
    @info = info
    @timebank = timebank
    @my_id = @info[:your_botid].to_s
    @op_id = @my_id == '0' ? '1' : '0'
  end

  def make_move
    @clock.start # starts timer
    move = new_move # computes move and stores it move
    make_move if appropriate?(@clock.stop, move) # new move if appropriate
    move # return current move otherwise
  end

  def appropriate?(move_time, move)
    enough_time?(@clock.stop) && new_move_conditions?(move)
  end

  def enough_time?(move_time) # checks if there is enough time to compute another move - implemented on very basic terms, here
    (@timebank -= move_time) > move_time
  end

  def new_move_conditions?(move) # evaluates if a new move is appropriate - set to false by default
    false
  end

  def new_move
    @random.new_move(@my_id, @op_id, @info[:field]) # requests a random move from random_move with players ids and field - other, more or less arguments can be passed, depending on the logic implemented in move class called
  end
end
