        ORG #6000;GLOBAL NAMES AND CONSTANTS.SCREEN_ADDR     EQU #4000SCREEN_SIZE     EQU #1800SCREEN_ATTRIB   EQU #5800ATTRIB_SIZE     EQU #300;MAIN PART        LD HL,#0000        ADD HL,SP        LD SP,#6000        PUSH HL        CALL SET_PIXEL_DEBUG        POP HL        LD SP,HL        RET ;GLOBAL STATIC VARIABLES.BACK_1: DUP #10        DW 0        EDUP ;BACK_PLANES WITH PIXELS.BACK_PLANES:        PUSH AF        PUSH BC        PUSH DE        PUSH HL        LD IX,BACK_1        LD B,#10        ;FILL DATA        LD DE,#0000B_PL_1: LD (IX+0),D        LD (IX+1),E        INC D        INC E        INC IX        INC IX        DJNZ B_PL_1     ;NEXT STAR        LD C,#10        ;MAIN LOOPB_PL_3: LD HL,BACK_1    ;DRAW PIXELS        LD B,#10B_PL_2: LD E,(HL)        INC HL        LD D,(HL)        LD A,1        CALL SET_PIXEL        INC HL        DJNZ B_PL_1        LD A,1        CALL SIMPLE_DELAY        ;LD HL,BACK_1   ;ERASE PIXELS        ;LD B,#10        ;LD E,(HL)        ;INC HL        ;LD D,(HL)        DEC C        LD A,C        OR B        JR NZ,B_PL_3        POP HL        POP DE        POP BC        POP AF        RET SET_PIXEL_DEBUG:        LD D,#00        LD E,%01000111        CALL CLEARSCREEN        LD DE,#0000DPIX_1: LD A,1        CALL SET_PIXEL       ;LD A,#1       ;CALL SIMPLE_DELAY        INC DE        LD A,D        OR E        JR NZ,DPIX_1TPIX    LD DE,#0000DPIX_2: LD A,0        CALL SET_PIXEL       ;LD A,#1       ;CALL SIMPLE_DELAY        DEC E        DEC D        LD A,D        OR E        JR NZ,DPIX_2        LD DE,#0000DPIX3:  XOR A        CALL SET_PIXEL        ;LD A,1        ;CALL SIMPLE_DELAY        DEC D        INC E        LD A,D        OR E        JR NZ,DPIX3        RET ;SET PIXEL ON SCREEN, WITH COORDINATES.;REGISTERS:;A = 1 - SET PIXEL, A = 0 - RESET PIXELS.;D - X(0..255), E - Y(0..191);RETURN: ON SCREEN.SET_PIXEL:        PUSH AF        PUSH BC        LD C,A        LD A,E        CP #C0        JR NC,PIX_E        PUSH DE        PUSH HL        LD HL,SCREEN_ADDR        LD A,E          ;2048 BYTES PART.        AND %11000000        RRCA         RRCA         RRCA         LD B,A        LD A,H        OR B        LD H,A        LD A,E          ;256 BYTES PART.        AND %00000111        LD B,A        LD A,H        OR B        LD H,A        LD A,E          ;32 BYTES PART.        AND %00111000        RLCA         RLCA         LD B,A        LD A,L        OR B        LD L,A        LD A,D          ;HORIZONTAL BYTE.        AND %11111000        RRCA         RRCA         RRCA         LD B,A        LD A,L        OR B        LD L,A        LD A,D          ;PIXEL IN BYTE.        AND %00000111        LD B,A        LD A,%10000000        JR Z,PIX_4      ;OPTIM.PIX_1:  RRCA         DJNZ PIX_1PIX_4:  LD B,A          ;IF FLAG A == 0.        LD A,C        OR A        JR NZ,PIX_2        LD A,B        CPL         AND (HL)        JR PIX_3PIX_2:  LD A,B        OR (HL)PIX_3:  LD (HL),A        POP HL        POP DEPIX_E:  POP BC        POP AF        RET ;SIMPLE DELAY FUNCTION FOR DEBUG.;A - DELAY IN 4 TACTS MULTIPLY IN 256.;RETURN: NOTHING.SIMPLE_DELAY:        PUSH AF        PUSH BC        LD A,B        LD C,0SIM_D:  NOP         DEC BC        LD A,B        OR C        JR NZ,SIM_D        POP BC        POP AF        RET ;CLEAR SCREEN FUNCTION.;D - BYTE FOR FILL SCREEN.;E - BYTE FOR FILL ATTRIBUTES.CLEARSCREEN:        PUSH AF        PUSH BC        PUSH DE        PUSH HL        LD HL,SCREEN_ADDR        LD BC,#1800CLR_1:  LD A,D        LD (HL),A        INC HL        DEC BC        LD A,B        OR C        JR NZ,CLR_1        LD BC,#300CLR_2:  LD A,E        LD (HL),E        INC HL        DEC BC        LD A,B        OR C        JR NZ,CLR_2        POP HL        POP DE        POP BC        POP AF        RET 