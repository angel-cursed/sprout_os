nasm src\main.asm -f bin -o build\main.bin
copy build\main.bin build\main_floppy.img
fsutil file setEOF build\main_floppy.img 1440000
qemu-system-i386 -fda build/main_floppy.img