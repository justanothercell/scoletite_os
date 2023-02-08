use crate::internal::io::{ByteWriter};

pub const BUFFER_HEIGHT: usize = 25;
pub const BUFFER_WIDTH: usize = 80;

static mut CONSOLE: ConsoleWriter = ConsoleWriter { x: 0, buffer: [[0;BUFFER_HEIGHT];BUFFER_WIDTH], buffer_initialized: false };

#[must_use]
pub fn console() -> ConsoleWriter{
    ConsoleWriter {
        x: 0,
        buffer: unsafe { *(0xb8000 as *mut [[u16;BUFFER_HEIGHT];BUFFER_WIDTH]) },
        buffer_initialized: true,
    }
}

pub fn debug_alive_ok(char: u8) {
    unsafe {
        let vga_buffer = 0xb8000 as *mut u32;
        *vga_buffer = 0x2f4b_2f4f;
        *vga_buffer.offset(1) = 0x2f00_2f3a | ((char as u32) << 16);
    }
}

#[repr(u8)]
#[allow(dead_code)]
pub enum Color {
    Black = 0,
    Blue = 1,
    Green = 2,
    Cyan = 3,
    Red = 4,
    Magenta = 5,
    Brown = 6,
    LightGray = 7,
    DarkGray = 8,
    LightBlue = 9,
    LightGreen = 10,
    LightCyan = 11,
    LightRed = 12,
    Pink = 13,
    Yellow = 14,
    White = 15,
}

pub struct ConsoleWriter {
    x: usize,
    buffer: [[u16;BUFFER_HEIGHT];BUFFER_WIDTH],
    buffer_initialized: bool
}

impl ConsoleWriter {
    pub fn ensure_init(&mut self) {
        if !self.buffer_initialized {
            self.buffer = unsafe { *(0xb8000 as *mut [[u16;BUFFER_HEIGHT];BUFFER_WIDTH]) };
            self.buffer_initialized = true;
        }
    }

    #[allow(dead_code)]
    pub fn print(&mut self, str: &str){
        for char in str.as_bytes() {
            self.write(*char)
        }
    }

    #[allow(dead_code)]
    pub fn println(&mut self, str: &str){
        for char in str.as_bytes() {
            self.write(*char)
        }
        self.write(b'\n')
    }

    pub fn new_line(&mut self) {
        for row in 1..BUFFER_HEIGHT {
            for col in 0..BUFFER_WIDTH {
                self.buffer[row - 1][col] = self.buffer[row][col];
            }
        }
        self.x = 0;
    }
}

impl ByteWriter for ConsoleWriter {
    fn write(&mut self, byte: u8) {
        match byte {
            b'\n' => {
                self.new_line()
            }
            b'\r' => self.x = 0,
            _ => {
                self.buffer[self.x][BUFFER_HEIGHT-1] = ((byte as u16) << 8) | Color::White as u16;
                self.x += 1;
            }
        }
        if self.x >= BUFFER_WIDTH {
            self.new_line()
        }
    }
}