MAIN := Omega.elf
ISO := Omega.iso

@echo Locating required files...
$(shell find src | grep .cr) Makefile ./src/amd64.ld
@echo Building executable...
@crystal build ./src/boot.cr --prelude=empty --static --cross-compile  --target "x86_64-pc-elf" --cross-compile --link-flags $(shell pwd)/src/amd64.ld -o Omega
@gcc Omega.o -o $(MAIN)
@echo Creating $(ISO)...
@mkdir -p iso/boot/grub
@cp $(MAIN) iso/boot/
@echo "set timeout=9" >> iso/boot/grub/grub.cfg
@echo 'menuentry \"Omega\" {' >> iso/boot/grub/grub.cfg
@echo "  multiboot /boot/$(MAIN)" >> iso/boot/grub/grub.cfg
@echo "}" >> iso/boot/grub/grub.cfg
@grub-mkrescue iso -o $(ISO)
@rm -rf $(MAIN)
@rm -rf ./iso
@rm -rf ./Omega.o
@echo Success!
