SECTIONS {
    .boot 0x7c00 : {
        asm/boot.o
    }

    .scoletite_os 0x7e00 : {
        target/scoletite_os.o
    }
    /*SECOND_STAGE_LENGTH = ((. - ADDR(.scoletite_os)) >> 9);*/
    SECOND_STAGE_LENGTH = 15;
}