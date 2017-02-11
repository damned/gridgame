require 'rspec'
require 'gridgame'

class TestConsole
  MESSAGE_ROWS = 2

  def initialize
    @released = false
  end

  # quack like a Console

  def output(screen_lines)
    @screen = screen_lines
  end

  def input(&handler)
    @input_handler = handler
  end

  def release
    @released = true
  end

  # test api

  def last_screen
    @screen
  end

  def game_area
    last_screen.first(last_screen.length - MESSAGE_ROWS)
  end

  def messages
    last_screen.last(MESSAGE_ROWS)
  end

  def simulate_input(char)
    @input_handler.call char
  end

  def right
    simulate_input 'r'
    self
  end

  def left
    simulate_input 'l'
    self
  end

  def released
    @released
  end
end

describe 'gridgame' do
  let(:console) { TestConsole.new }
  subject(:game) { Gridgame.new console }

  before { game.start }

  it 'starts by displaying a small default game area with player and destination on it' do
    expect(console.game_area).to eq ['...X.',
                                     '.....',
                                     '@....']
  end

  it "moves player right if hit 'r'" do
    console.simulate_input 'r'
    expect(console.game_area).to eq ['...X.',
                                     '.....',
                                     '.@...']
  end

  it "does not move player right if hit key other than 'r'" do
    console.simulate_input 'j'
    expect(console.game_area.last).to eq '@....'
  end

  it 'moves player right multiple times' do
    console.right.right.right
    expect(console.game_area.last).to eq '...@.'
  end

  it 'can move player left' do
    console.right.right.simulate_input 'l'
    expect(console.game_area.last).to eq '.@...'
  end

  it 'can move player up' do
    console.simulate_input 'u'
    expect(console.game_area).to eq ['...X.',
                                     '@....',
                                     '.....']
  end

  it 'does not allow movement off left edge' do
    console.left
    expect(console.game_area.last).to eq '@....'
    expect(console.messages.first).to eq 'Cannot move there'
  end

  it 'does not allow movement off right edge' do
    console.right.right.right.right.right
    expect(console.last_screen[2]).to eq '....@'
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
    expect(console.messages.last).to include 'Move: lr'
    expect(console.messages.last).to include 'Quit: q'
  end
end
