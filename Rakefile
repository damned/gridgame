require_relative 'lib/gridgame'

task 'run' do
  config = GameConfig.new.
      with_size(20, 10).
      with_player_at(1, 8).
      with_destination_at(18, 1)
  Gridgame.new(config: config).start
end