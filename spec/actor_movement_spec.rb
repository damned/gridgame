require 'rspec'
require 'gridgame'
require_relative 'test_console'

describe 'gridgame' do
  let(:console) { TestConsole.new }
  let(:config) { GameConfig.new.with_actor_at(1, 1) }

  subject(:game) { Gridgame.new(console: console, config: config) }

  before { game.start }

  describe 'actor movement' do

    it 'shows actor at start position' do
      expect(console.game_area).to eq ['...X.',
                                       '.a...',
                                       '@....']
    end

    it 'moves actor to right each tick' do
      console.up
      expect(console.game_area).to eq ['...X.',
                                       '@.a..',
                                       '.....']
      console.left
      expect(console.game_area).to eq ['...X.',
                                       '@..a.',
                                       '.....']
    end

    it 'actor turns right and moves if blocked' do
      console.up.up.up.up
      expect(console.game_area).to eq ['@..X.',
                                       '.....',
                                       '....a']
      console.up
      expect(console.game_area).to eq ['@..X.',
                                       '.....',
                                       '...a.']
      console.up.up.up.up
      expect(console.game_area).to eq ['@..X.',
                                       'a....',
                                       '.....']
      console.up.up
      expect(console.game_area).to eq ['@a.X.',
                                       '.....',
                                       '.....']
      console.up.up.up.up
      expect(console.game_area).to eq ['@..X.',
                                       '....a',
                                       '.....']
    end
  end
end
