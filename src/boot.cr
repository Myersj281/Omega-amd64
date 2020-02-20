#Initialize devices
require "./dev/video/vga"
require "./dev/input/keyboard"

#Import kernel
require "Omega"


@[Naked]
fun __entry()
  asm("mov $0, %esp" : : "Z"(0x00100000 + 0x1000));
  asm("push 0");
  asm("push 0");
  asm("call main")
  asm("hlt")
end
