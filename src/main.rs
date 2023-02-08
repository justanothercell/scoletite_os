#![feature(lang_items, core_intrinsics)]
#![feature(const_mut_refs)]
#![no_std]
#![no_main]

mod internal;

use core::panic::PanicInfo;
use crate::internal::io::console::{console, debug_alive_ok};

#[panic_handler]
fn panic(_info: &PanicInfo) -> ! {
    loop {}
}


#[no_mangle]
pub extern "C" fn _start() -> ! {
    debug_alive_ok(b'A');
    debug_alive_ok(b'B');
    console().println("Hello world!");
    debug_alive_ok(b'C');
    loop {}
    // console().println("Hello world!");

    console().println("Welcome to scoletite OS!");
    //printer.write_fmt();
    //write!(printer, "foo: {}", 1);
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