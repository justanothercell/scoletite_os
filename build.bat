@echo off

cd asm
nasm boot.asm -f elf64 -o boot.o
cd ..

rem for debugging we emit asm
cargo rustc -- --emit asm
cargo rustc -- --emit obj

rm target/scoletite_os-220910d111119d57.o

cd target/target/debug/deps
copy "scoletite_os-220910d111119d57.o" "../../../scoletite_os.o"
cd ../../../..

ld asm/boot.o target/scoletite_os.o -T link.ld
