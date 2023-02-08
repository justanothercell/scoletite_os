# Scoletite OS
A x86-64 Kernel/OS

## ATTENTION
This is probably only compilable on 64-bit systems 
due to rust's core crate having problems with transpiling.
You might want to try [xargo](https://github.com/japaric/xargo) which i did not end up using but
claims to be able to cross compile rust core.

## Build & Run
see [run.bat](run.bat) or [run.sh](run.sh) respectively

## Tools / Setup Steps
- [QEMU](https://www.qemu.org) VM
- [NASM](https://www.nasm.us/) assembler
- lld (llvm's version of ld, but ld works as well)
- [Hexdump](https://gist.github.com/DragonFIghter603/37a95b3f1f87d23d5410bfabf05a867b) self created, optional to view image and can be replaced by any real tool


## Resources
- [x86 and amd64 instruction reference [OSDev Wiki]](https://www.felixcloutier.com/x86/)<br>
  specifically [Setting Up Long Mode](https://wiki.osdev.org/Setting_Up_Long_Mode) 
- [standalone x64 hello world bootloader in asm](https://50linesofco.de/post/2018-02-28-writing-an-x86-hello-world-bootloader-with-assembly)
- [OS Tutorial [Repo]](https://github.com/cfenollosa/os-tutorial)
- [Minimal Rust Kernel by Philipp Oppermann](https://os.phil-opp.com/minimal-rust-kernel/)
- [Phillip Oppermann's tutorial on entering long mode [DEPRECATED]](https://os.phil-opp.com/entering-longmode/)