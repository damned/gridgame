require 'rspec'
require 'gridgame'

class TestConsole
  def output(screen_lines)
    @screen = screen_lines
  end

  def last_screen
    @screen
  end

  def input

  end
end


describe 'gridgame' do
  let(:console) { TestConsole.new }
  subject(:game) { Gridgame.new console }
  
  it 'starts by displaying a small default game area' do
    game.start
    expect(console.last_screen).to eq ['.....', 
                                       '.....', 
                                       '.....']        
  end

end
