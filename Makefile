all: build/image.iso

build/image.iso: build/entry.bin grub.cfg
	mkdir -p build/isodir/boot/grub
	cp grub.cfg build/isodir/boot/grub
	cp build/entry.bin build/isodir/boot
	grub-mkrescue -o build/image.iso build/isodir

build/entry.bin: build/entry.o linker.ld
	ld build/entry.o -T linker.ld -e multiboot_header --oformat binary -s -o build/entry.bin
	
build/entry.o: entry.s
	mkdir -p build
	nasm -f elf64 entry.s -o build/entry.o

clean:
	rm -rf build
