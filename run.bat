@echo off

cd asm
nasm boot.asm -f elf64 -o boot.o
cd ..

cargo rustc -Z build-std=core -- --emit obj=target/scoletite_os_raw.o --emit asm=target/scoletite_os_raw.asm

ld.lld asm/boot.o target/scoletite_os.o -T link.ld --oformat binary -o img.bin

qemu-system-x86_64 -drive format=raw,file=img.bin