require 'rspec'
require_relative '../lib/ui/console'
require 'gridgame'
require_relative 'test_console'

describe 'gridgame' do
  let(:console) { TestConsole.new }
  let(:config) { GameConfig.new }
  subject(:game) { Gridgame.new console: console, config: config }

  before { game.start }

  it 'starts by displaying a small default game area with player and destination on it' do
    expect(console.game_area).to eq ['...X.',
                                     '.....',
                                     '@....']
  end

  it 'moves player right if hit right arrow' do
    console.simulate_input 'right'
    expect(console.game_area).to eq ['...X.',
                                     '.....',
                                     '.@...']
  end

  it 'does not move player right if hit another key' do
    console.simulate_input 'j'
    expect(console.game_area.last).to eq '@....'
  end

  it 'moves player right multiple times' do
    console.right.right.right
    expect(console.game_area.last).to eq '...@.'
  end

  it 'can move player left' do
    console.right.right.simulate_input 'left'
    expect(console.game_area.last).to eq '.@...'
  end

  it 'can move player up' do
    console.simulate_input 'up'
    expect(console.game_area).to eq ['...X.',
                                     '@....',
                                     '.....']
  end

  it 'can move player down' do
    console.up.up.right.simulate_input 'down'
    expect(console.game_area).to eq ['...X.',
                                     '.@...',
                                     '.....']
  end

  it 'can move player up into destination row' do
    console.up.up
    expect(console.game_area).to eq ['@..X.',
                                     '.....',
                                     '.....']
  end

  it 'does not allow movement off left edge' do
    console.left
    expect(console.game_area.last).to eq '@....'
    expect(console.messages.first).to eq 'Cannot move there'
  end

  it 'does not allow movement off right edge' do
    console.right.right.right.right.right
    expect(console.game_area.last).to eq '....@'
    expect(console.messages.first).to eq 'Cannot move there'
  end

  it 'does not allow movement off top edge' do
    console.up.up.up.up
    expect(console.game_area.first).to eq '@..X.'
    expect(console.messages.first).to eq 'Cannot move there'
  end

  it 'does not allow movement off bottom edge' do
    console.down
    expect(console.game_area.last).to eq '@....'
    expect(console.messages.first).to eq 'Cannot move there'
  end

  it 'clears message the cycle after stopped at edge' do
    console.left.right
    expect(console.last_screen[2]).to eq '.@...'
    expect(console.messages.first).to eq ''
  end

  it "will exit on 'q'" do
    console.simulate_input 'q'
    expect(console.released).to eq true
  end

  it 'shows keys' do
    expect(console.messages.last).to include 'Move: arrows'
    expect(console.messages.last).to include 'Quit: q'
  end

  it 'shows player attributes' do
    expect(console.player_status).to include 'Player: 0XP'
  end

  it 'ends game at destination' do
    console.up.up.right.right.right
    expect(console.last_screen.last).to eq 'Reached destination'
    expect(console.released).to eq true
  end

  context 'customized game definition' do
    describe 'custom size' do
      let(:config) { GameConfig.new.with_size(4, 4) }

      it 'can change game size' do
        expect(console.game_area).to eq ['...X',
                                         '....',
                                         '@...',
                                         '....']
      end

      it 'limits at custom game area size' do
        console.right.right.right.right.right.down.down
        expect(console.game_area).to eq ['...X',
                                         '....',
                                         '....',
                                         '...@']
      end
    end

    describe 'custom positions' do
      let(:config) { GameConfig.new.with_size(4, 4)
                         .with_player_at(3, 1)
                         .with_destination_at(0, 3) }

      it 'limits at custom game area size' do
        expect(console.game_area).to eq ['....',
                                         '...@',
                                         '....',
                                         'X...']
      end
    end

    describe 'a blocker' do
      let(:config) { GameConfig.new.with_blocker_at(1, 2) }

      it 'stops player moving over it' do
        console.right
        expect(console.game_area).to eq ['...X.',
                                         '.....',
                                         '@B...']
      end
    end
  end

  describe 'attributes' do
    describe 'experience' do
      let(:config) { GameConfig.new.with_experience_builder_at(0, 0) }

      it 'player experience increases more when moving over experience builder' do
        expect(console.game_area).to eq ['+..X.',
                                         '.....',
                                         '@....']
        console.up
        expect(console.player_status).to include '1XP'
        console.up
        expect(console.player_status).to include '22XP'
      end

      it 'no experience boost waiting over builder' do
        console.up.up.wait
        expect(console.player_status).to include '23XP'
      end
    end
  end

  describe 'takeable objects' do
    let(:config) { GameConfig.new.with_charming_chain_at(1, 1) }

    it 'allows player to take takeable objects' do
      expect(console.game_area[1][1]).to eq 'c'
      console.up.right
      expect(console.messages.first).to include 'charming chain'
      console.take.right
      expect(console.game_area[1][1]).to eq '.'
    end

  end
end
