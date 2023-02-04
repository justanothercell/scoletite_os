ENTRY(_boot)

SECTIONS {
    .boot 0x7c00 : {
        boot.o;
    }
}