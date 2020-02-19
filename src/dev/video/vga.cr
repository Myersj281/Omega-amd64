require "LibO"


struct Screen
  def initialize()
    @framebuffer = Pointer(UInt16).new(0xb8000u64)
    @x = 0
    @y = 0
    80.times do |x|
      16.times do |y|
        @framebuffer[y * 80 + x] = 0u16
      end
    end
  end
  
  private def put_byte(byte)
    if byte == '\n'.ord
      @x = 0
      @y += 1
      return
    end
    @framebuffer[@y * 80 + @x] = ((15u16 << 8) | (0u16 << 12) | byte).as UInt16
    @x += 1
    if @x == 80
      @x = 0
      @y += 1
    end
  end

  def print(string : String)
    string.each_byte do |char| 
      put_byte char
    end
  end
end


STDOUT = Screen.new
def self.print(line : String)
  STDOUT.print(line)
end

def self.puts(line : String)
  print line
  print "\n"
end

def self.clear()
  STDOUT.clear
end
