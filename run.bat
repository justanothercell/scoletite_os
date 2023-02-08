@echo off

cd asm
    nasm boot.asm -f elf64 -o boot.o
cd ..

cargo rustc -Z build-std=core -Z build-std-features=panic_immediate_abort --target target.json --release -- --emit obj=target/scoletite_os.o --emit link=target/scoletite_os.a --emit asm=target/scoletite_os.asm --emit dep-info=target/scoletite_os.dep-info

del img.bin

ld.lld asm/boot.o target/scoletite_os.o  -T link.ld --oformat binary -o img.bin -Map=img.map

qemu-system-x86_64 -drive format=raw,file=img.bin