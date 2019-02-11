EFI_CRT=/usr/lib32/crt0-efi-ia32.o
EFI_LDS=/usr/lib32/elf_ia32_efi.lds
EFI_INCLUDE=-I/usr/include/efi/ia32

all: build/main.efi

build/main.efi: build/main.so
	objcopy -j .text -j .sdata -j .data -j .dynamic \
		-j .dynsym  -j .rel -j .rela -j .reloc \
		--target=efi-app-ia32 build/main.so build/main.efi


build/main.so: build/main.o
	ld -nostdlib -znocombreloc -T $(EFI_LDS) -shared -Bsymbolic -L/usr/lib32 \
		$(EFI_CRT) build/main.o -o build/main.so -lefi -lgnuefi 

build/main.o: main.c
	mkdir -p build
	gcc -fpic -Wall -fshort-wchar -fno-strict-aliasing -fno-merge-constants -m32 -march=i686 \
		$(EFI_INCLUDE) -c main.c -o build/main.o

clean:
	rm -rf build
