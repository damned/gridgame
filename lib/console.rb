class Console
  def intitialize
    @release = false
  end
  def output(lines)
    lines.each {|line|
      STDOUT.puts line
    }
  end
  def input
    while (c = STDIN.getc) do
      break if @release
      yield c
    end
  end
  def release
    @release = true
  end
end