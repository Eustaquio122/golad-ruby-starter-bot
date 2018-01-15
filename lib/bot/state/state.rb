class State
  attr_reader :info

  def initialize # initializes info hash with two instances of Player for self and opponent
    @info = {
      me: Player.new,
      opponent: Player.new
    }
  end

  def update_info(args) # receives array with input string elements minus first ('settings'/'update' has been reomved at this point)
    return handle_game(args) if args[0] == 'game' # handles 'update game' instructions if first element in array is 'game'
    return assign_your_bot(args) if args[0] == 'your_bot' # calls method to assign your bot name for 'settings your_bot p'
    return handle_player(args) if args[0].include?('player') # calls method to handle 'update p ...' instructions
    @info[args[0].to_sym] = args[1].to_i # for all other instructions, treats it them as a general case and adds a key to @info named after the instruction, with a corresponding value of the last element converted to int [example: 'field_width 16' will add 'field_width: 16' to @info]
  end

  private

  def handle_game(args)
    return update_info(args[1..-1]) if args[1] == 'round' # if 'game round ...', calls update_info again as it can be parsed as a general case
    handle_field(args[-1]) # request field to be processed if 'game field'
  end

  def handle_field(arg)
    @info[:field] = [] # either initializes or resets @info[:field]
    parse_field(arg)
  end

  def parse_field(arg) # creates a 2d array representation of field
    return if arg == '' # stops if no info left to parse
    @info[:field] << arg.slice!(0...@info[:field_width]).chars # creates an array with a field line and adds it to 2d array
    parse_field(arg) # recursive call to keep processing field lines
  end

  def assign_your_bot(args)
    @info[args[0].to_sym] = args[1] # adds your_bot: name to @info
  end

  def handle_player(args)
    return update_living_cells(args) if args[1] == 'living_cells'
    return update_last_move(args) if args[1] == 'move'
    update_player_names(args)
  end

  def update_living_cells(args) # matches with appropriate @player and updates requests it to update living cells
    return @info[:me].update_living_cells(args[2].to_i) if args[0] == @info[:your_bot]
    @info[:opponent].update_living_cells(args[2].to_i)
  end

  def update_last_move(args)
    @info[:opponent].update_last_move(args[2])
  end

  def update_player_names(args) # matches names with player using you_bot and assigns them appropriately to each player
    names = args[1..-1]
    names.reverse if names[0] != @info[:your_bot]
    @info[:me].update_name(names[0])
    @info[:opponent].update_name(names[1])
  end
end
