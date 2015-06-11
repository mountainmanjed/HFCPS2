;SSF2X training mode code
;Address setting 28 bytes
41F9 00FF 844E		lea $ff844e,A0
43F9 00FF 884E		lea $ff884e,A1
45F9 00FF F100		lea $fff100,A2
6108				bsr; PC+$08
C149				exg A0,A1
45F9 00FF F200		lea $fff200,A2; 2P timer

;Timer set and countdown 6
4A2A 0000			tst.b ($0,A2);checks if there is a timer already
6710	 			beq; PC+$10 | Timer = 0 branch to refill 

;Hitstop check and Subtraction 16 bytes
4A29 0003			tst.b ($3,A1)
6608				bne; PC+$08 | If hurt skip subtraction
102A 0000			move.b ($0,A2), D0
5300				subq.b #1,D0
1480				move.b D0, (A2)
4E75				rts

;Refill 30 bytes
157C 0096 0000 		move.b #$96, ($0,A2); Refill Timer
117C 0030 02B4		move.b #$30, ($2B4,A0); Refill Super
303C 0090			move.w #$90, D0
3340 01BC			move.w D0, ($1bc, A1); Refill Graphic
3340 002A			move.w D0, ($2a, A1); Refill Life
3340 002C 			move.w D0, ($2c, A1); Refill Life
4E75				rts
