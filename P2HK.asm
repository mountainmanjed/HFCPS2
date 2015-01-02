;Player 2 Kicks
;Original code
;01D2E6: lsr.w   #4, D1;replace with a jsr $Kickcode
;01D2E8: andi.b  #$7, D1;
;01D2EC: move.b  D1, ($7e,A5);Move to Player 2 controls

;New Code
01D2E6: jsr     $kickcode;4EB9 Location
01D2EC: move.b  D1, ($7e,A5);Move to Player 2 controls

;jsr $Kickcode
;Need D0 to equal 40 with out input and 0 with add it to d1
move.b  $804020.l ;(1039 0080 4020)
andi.b 	#$40, D0 ;(0240 0040)
add.b D0,D1 ;(D200)
lsr.w #$4, D1 ;(E849)
andi.b #$7, D1 ;(0241 0007)
rts ;(4e75)
