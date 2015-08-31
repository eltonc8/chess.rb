require 'io/console'

# Reads keypresses from the user including 2 and 3 escape character sequences.
def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

def get_arrow_keys
  c = read_char

  case c
  when "\e[A"
    return :up
  when "\e[B"
    return :down
  when "\e[C"
    return :right
  when "\e[D"
    return :left
  when "\r"
    return :return
  when "\u0003"
    puts "CONTROL-C"
    exit 0
  when /^.$/
    c.to_sym
  end
end
