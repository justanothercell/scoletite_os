ENTRY(_boot)

SECTIONS {
    .boot 0x7c00 : {
        boot.o;
    }
    /* SECOND_STAGE_LENGTH = ((. - ADDR(._start)) >> 9);*/
    SECOND_STAGE_LENGTH = 0;
}