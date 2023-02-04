@echo off

cd asm
nasm boot.asm -f elf64 -o boot.o
cd ..

cargo rustc -Z build-std=core -- --emit obj=target/scoletite_os.o

ld.lld asm/boot.o target/scoletite_os.o -T link.ld -o img.bin

qemu-system-x86_64 -drive format=raw,file=img.bin