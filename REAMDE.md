# Scoletite OS
A x86-64 Kernel/OS

## Build & Run
see [run.bat](run.bat)

most if not all command should be a 1:1 replacement for unix systems

## Tools / Setup Steps
- [QEMU](https://www.qemu.org) VM
- [NASM](https://www.nasm.us/) assembler
- lld (llvm's version of ld, but ld workaswell)
- [Hexdump](https://gist.github.com/DragonFIghter603/37a95b3f1f87d23d5410bfabf05a867b) self created, optional to view image and can be replaced by any real tool
- `cargo install xargo`
- 
## Resources
- [x86 and amd64 instruction reference](https://www.felixcloutier.com/x86/)
- [standalone x64 hello world bootloader in asm](https://50linesofco.de/post/2018-02-28-writing-an-x86-hello-world-bootloader-with-assembly)