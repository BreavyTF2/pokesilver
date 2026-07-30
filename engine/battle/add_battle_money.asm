AddBattleMoneyToAccount:
	ld c, 3
	and a
	push de
.loop
	ld a, [de]
	adc [hl]
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .loop
	pop hl
	ld a, [hld]
	cp LOW(MAX_MONEY)
	ld a, [hld]
	sbc HIGH(MAX_MONEY) ; mid
	ld a, [hl]
	sbc HIGH(MAX_MONEY >> 8)
	ret c
	ld [hl], HIGH(MAX_MONEY >> 8)
	inc hl
	ld [hl], HIGH(MAX_MONEY) ; mid
	inc hl
	ld [hl], LOW(MAX_MONEY)
	ret
