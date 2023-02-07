#![no_std]
#![no_main]

use core::arch::asm;
use core::panic::PanicInfo;

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}

// static HELLO: &[u8] = b"Hello World!!!!";

#[no_mangle]
pub extern "C" fn _start() -> ! {
    let mut vga_buffer = 0xb8000 as *mut u32;
    for i in 0..10 {
        unsafe {
            *vga_buffer.offset(i * 2) = 0x2f4b2f4f;
        }
    }

    /*
    let vga_buffer = 0xb8000 as *mut u8;
    /*
    for (i, &byte) in HELLO.iter().enumerate() {
        unsafe {
            *vga_buffer.offset(i as isize * 2) = byte;
            *vga_buffer.offset(i as isize * 2 + 1) = 0xb;
        }
    }
    */
    unsafe {
        *vga_buffer.offset(0 * 2) = b'H';
        *vga_buffer.offset(0 * 2 + 1) = 0xb;
    }
    unsafe {
        *vga_buffer.offset(1 * 2) = b'I';
        *vga_buffer.offset(1 * 2 + 1) = 0xb;
    }
    unsafe {
        *vga_buffer.offset(2 * 2) = b'!';
        *vga_buffer.offset(2 * 2 + 1) = 0xb;
    }
    loop {}

     */
    loop {}
}