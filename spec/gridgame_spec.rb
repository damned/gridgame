require 'rspec'
require 'gridgame'

class TestConsole

  # quack like a Console

  def output(screen_lines)
    @screen = screen_lines
  end

  def input(&handler)
    @input_handler = handler
  end

  # test api

  def last_screen
    @screen
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
end

describe 'gridgame' do
  let(:console) { TestConsole.new }
  subject(:game) { Gridgame.new console }

  before { game.start }

  it 'starts by displaying a small default game area with player and destination on it' do
    expect(console.last_screen).to eq ['...X.',
                                       '.....', 
                                       '@....', '']
  end

  it "moves player right if hit 'r'" do
    console.simulate_input 'r'
    expect(console.last_screen).to eq ['...X.',
                                       '.....',
                                       '.@...', '']
  end

  it "does not move player right if hit key other than 'r'" do
    console.simulate_input 'j'
    expect(console.last_screen[2]).to eq '@....'
  end

  it 'moves player right multiple times' do
    console.right.right.right
    expect(console.last_screen[2]).to eq '...@.'
  end

  it 'can move player left too' do
    console.right.right.left
    expect(console.last_screen[2]).to eq '.@...'
  end

  it 'does not allow movement off left edge' do
    console.left
    expect(console.last_screen[2]).to eq '@....'
    expect(console.last_screen.last).to eq 'Cannot move there'
  end

end
