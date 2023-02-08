use core::fmt;

pub mod console;

pub trait ByteReader {
    fn read(&mut self) -> Option<u8>;
}

impl Iterator for dyn ByteReader {
    type Item = u8;

    fn next(&mut self) -> Option<Self::Item> {
        self.read()
    }
}

pub trait ByteWriter {
    fn write(&mut self, byte: u8);
}

impl fmt::Write for dyn ByteWriter {
    fn write_str(&mut self, s: &str) -> fmt::Result {
        for char in s.as_bytes() {
            self.write(*char)
        }
        Ok(())
    }
}