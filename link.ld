ENTRY(_boot)

SECTIONS {
    .boot 0x7c00 : {
        boot.o;
        . = ALIGN(512);
    }

    .scoletite_os 0x7e00 : {
        scoletite_os.o;
    } = 0xdeadc0de

    SECOND_STAGE_LENGTH = ((. - ADDR(.scoletite_os)) >> 9);
}