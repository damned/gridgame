class Console
  def output(lines)
    lines.each {|line|
      STDOUT.puts line
    }
  end
  def input
    while c = STDIN.getc do
      yield c
    end
  end
end