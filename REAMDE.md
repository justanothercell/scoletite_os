# Scoletite OS
A x86-64 Kernel/OS

## Build & Run
see [run.bat](run.bat)

most if not all command should be a 1:1 replacement for unix systems

## Tools / Setup Steps
- [QEMU](https://www.qemu.org) VM
- [NASM](https://www.nasm.us/) assembler
- lld (llvm's version of ld, but ld should work aswell)
- `rustup target add x86_64-unknown-none`