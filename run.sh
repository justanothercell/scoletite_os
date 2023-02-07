#!/usr/bin/env bash

pushd asm
	nasm boot.asm -f elf64 -o boot.o
popd

cargo rustc -Z build-std=core --target target.json --release -- --emit obj=target/scoletite_os.o --emit asm=target/scoletite_os.asm

rm -f img.bin

ld.lld asm/boot.o target/scoletite_os.o -T link.ld --oformat binary -o img.bin -Map=img.map

qemu-system-x86_64 -drive format=raw,file=img.bin