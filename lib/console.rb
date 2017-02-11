require 'io/console'
class Console
  def intitialize
    @release = false
    instream.raw!
  end

  def output(lines)
    lines.each {|line|
      STDOUT.puts line
    }
  end

  def input
    while (c = instream.getch) do
      yield c
      break if @release
    end
  end

  def release
    @release = true
  end

  private

  def instream
    STDIN
  end

end