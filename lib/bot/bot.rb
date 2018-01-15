class Bot
  def initialize
    @state = State.new
    @action = Action.new
    @formatter = Formatter.new
  end

  def run
    while line = gets # reads lines from stdin
      line.chomp == '' || parse(line.chomp) #parses each non-empty line
    end
    run #re-launches listener
  end

  private

  def parse(line)
    formatted_line = @formatter.format_input(line) #returns an array with each input element formatted
    case formatted_line.shift #removes first element of the array for evaluation
    when 'action'
      print @formatter.format_output(action(formatted_line.last)) # requests a new action with last element of array [timebank], formats action output, and sends it to stdout
    when 'settings', 'update'
      @state.update_info(formatted_line) # sends array with instructions to state if 'settings' ot 'update'
    when 'quit'
      exit(true) # stops running if 'quit'
    end
  end

  def action(timebank)
    @action.new_action(timebank.to_i, @state.info) # calls action with timebank and updated @info hash State
  end
end
