#!/usr/bin/env ruby

# Written by Eustaquio122, peterwdj, RobertClayton, and SuzanneHuldt

require_relative 'lib/bot/bot'
require_relative 'lib/bot/formatter'
require_relative 'lib/bot/state/state'
require_relative 'lib/bot/state/player'
require_relative 'lib/action/action'
require_relative 'lib/action/clock'
require_relative 'lib/action/moves/random_move'


def main
  $stdout.sync = true # sets up immediate output flush
  Bot.new.run
end

main
