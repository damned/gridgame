require_relative 'lib/gridgame'

task 'test' do
  system 'rspec'
end

task 'run' do
  Gridgame.new(config: DefaultGameConfig.new).start
end

task 'shoes' do
  Gridgame.new(config: DefaultGameConfig.new, console: ShoesConsole.new).start
end