require 'rspec'
require 'gridgame'

class TestConsole
  def output(screen_lines)
    @screen = screen_lines
  end

  def last_screen
    @screen
  end

  def input(&handler)
    @input_handler = handler
  end

  def simulate_input(char)
    @input_handler.call char
  end
end


describe 'gridgame' do
  let(:console) { TestConsole.new }
  subject(:game) { Gridgame.new console }
  
  it 'starts by displaying a small default game area with player on it' do
    game.start
    expect(console.last_screen).to eq ['.....', 
                                       '.....', 
                                       '@....']
  end

  it "moves player right if hit 'r'" do
    game.start
    console.simulate_input 'r'
    expect(console.last_screen).to eq ['.....',
                                       '.....',
                                       '.@...']
  end

  it "does not move player right if hit key other than 'r'" do
    game.start
    console.simulate_input 'j'
    expect(console.last_screen.last).to eq '@....'
  end

end
