require 'rspec'
require_relative '../lib/position'

describe Position do
  describe '#==' do
    it 'equals position with same x, y' do
      expect(Position.new(1, 2)).to eq Position.new(1, 2)
    end
  end
end