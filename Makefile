EFI_CRT=/usr/lib/crt0-efi-x86_64.o
EFI_LDS=/usr/lib/elf_x86_64_efi.lds
EFI_INCLUDE=-I/usr/include/efi/x86_64
EFI_LIBS=-lefi -lgnuefi $(shell $(CC) -print-libgcc-file-name)

all: build/main.efi

build/main.efi: build/main.so
	objcopy -j .text -j .sdata -j .data -j .dynamic \
		-j .dynsym  -j .rel -j .rela -j .reloc \
		--target=efi-app-x86_64 build/main.so build/main.efi


build/main.so: build/main.o
	ld -nostdlib -znocombreloc -T $(EFI_LDS) -shared -Bsymbolic -L/usr/lib \
		$(EFI_CRT) build/main.o -o build/main.so $(EFI_LIBS) 

build/main.o: main.c
	mkdir -p build
	gcc -fPIC -ffreestanding -fshort-wchar -fno-strict-aliasing -fno-merge-constants -mno-red-zone \
		$(EFI_INCLUDE) -Wall -c main.c -o build/main.o

clean:
	rm -rf build
