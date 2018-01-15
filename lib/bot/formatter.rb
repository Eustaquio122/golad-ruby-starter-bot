class Formatter
  def format_input(input_line)
    input_line.tr!(',', ' ') if input_line.include?('player_names') # replaces comma separating player names with a space, to store each name in a different position of returning array
    input_line.delete!(',') if input_line.include?('game field') # deletes commas from field, joining each cell value in a single word to be returned at the end of the array
    input_line.split(' ') # splits each input word into an array
  end

  def format_output(action)
    action.join(' ') + "\n" # converts array with action instructions into an output string, adding /n
  end
end
