SECTIONS {
    .boot 0x7c00 : {
        boot.o;
    }

    .hello_rust 0x7e00 : {
        scoletite_os.o;
        . = ALIGN(512);
    } = 0xdeadc0de

    SECOND_STAGE_LENGTH = ((. - ADDR(._start)) >> 9);
}