require_relative 'lib/gridgame'

task 'test' do
  system 'rspec'
end

task 'run' do
  config = GameConfig.new.
      with_size(20, 10).
      with_player_at(1, 8).
      with_destination_at(18, 1).
      with_blocker_at(4, 9).
      with_actor_at(14, 3)

  Gridgame.new(config: config).start
end