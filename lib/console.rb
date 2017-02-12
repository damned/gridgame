require 'remedy'
class Console
  include Remedy
  def intitialize
    @release = false
  end

  def output(lines)
    lines.each {|line|
      STDOUT.puts line
    }
  end

  def input
    interaction = Interaction.new
    interaction.loop do |key|
      yield key.to_s
      break if @release
    end
  end

  def release
    @release = true
  end

end