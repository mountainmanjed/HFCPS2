;CPS2 Qsound write
;pretty much same function every game
;Only differences so far are the noted memory locations and place of code in the ROMs
;From Megaman Power Battles 1 CPS2 version
;(GAME) = Game Dependant
;Just need to use a jsr.

	7000                       moveq   #$0, D0;Clear D0 a lot of functions start with this.

	;Stereo Check
	4A2D 0093                  tst.b   ($93,A5);(GAME)
	6702                       beq     $1efa0
	
	;Enabling Stereo
	70FF                       moveq   #-$1, D0
	
	;0 Mono or FF Stereo
	13C0 0061 9FFD             move.b  D0, $619ffd.l

	;if the same slot then return
	302D A054                  move.w  (-$5fac,A5), D0;(GAME)
	B06D A052                  cmp.w   (-$5fae,A5), D0;(GAME)
	6700 0088                  beq     $1f038
	
	;If playing return
	0C39 00FF 0061 801F        cmpi.b  #-$1, $61801f.l
	667C                       bne     $1f038
	
	49ED 9052                  lea     (-$6fae,A5), A4;Writing Sound Engine Address(GAME)
	302D A054                  move.w  (-$5fac,A5), D0;Getting offset(GAME)
	
	13F4 0000 0061 8007        move.b  (A4,D0.w), $618007.l;Song ID
	13F4 0001 0061 8009        move.b  ($1,A4,D0.w), $618009.l;Song ID
	13F4 0002 0061 8001        move.b  ($2,A4,D0.w), $618001.l
	13F4 0003 0061 8003        move.b  ($3,A4,D0.w), $618003.l
	13F4 0004 0061 8005        move.b  ($4,A4,D0.w), $618005.l
	13F4 0005 0061 800D        move.b  ($5,A4,D0.w), $61800d.l;Usually 0x10 changes does nothing on 0.154
	13F4 0006 0061 800F        move.b  ($6,A4,D0.w), $61800f.l
	13F4 0007 0061 8011        move.b  ($7,A4,D0.w), $618011.l
	13F4 0008 0061 8017        move.b  ($8,A4,D0.w), $618017.l
	13F4 0009 0061 8019        move.b  ($9,A4,D0.w), $618019.l
	13F4 000A 0061 8013        move.b  ($a,A4,D0.w), $618013.l
	13F4 000B 0061 8015        move.b  ($b,A4,D0.w), $618015.l
	13FC 0000 0061 801F        move.b  #$0, $61801f.l;Play
	;When Working correctly, something writes 0xFF in 61801F place after a song plays.
	;The Z80's doing.
	
	;Sound Engine Slot advancement
	0640 0010                  addi.w  #$10, D0
	0240 0FF0                  andi.w  #$ff0, D0
	3B40 A054                  move.w  D0, (-$5fac,A5);(GAME)
	4E75                       rts
