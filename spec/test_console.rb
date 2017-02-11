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

  def up
    simulate_input 'u'
    self
  end

  def down
    simulate_input 'd'
    self
  end

  def released
    @released
  end
end