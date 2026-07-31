CanLearnTMHMMove:
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wBaseTMHM
	push hl

	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, 0
	ld hl, TMHMMoves
.loop
	ld a, [hli]
IF DEF(_09_30) || DEF(_10_06) || DEF(_REV0) || DEF(_REV1)
	and a
	jr z, .end
ENDC
	cp b
	jr z, .found
	inc c
	jr .loop

.found
	pop hl
	ld b, CHECK_FLAG
	push de
	ld d, 0
	predef SmallFarFlagAction
	pop de
	ret

IF DEF(_09_30) || DEF(_10_06) || DEF(_REV0) || DEF(_REV1)
.end
	pop hl
	ld c, 0
	ret
ENDC

GetTMHMMove:
	ld a, [wTempTMHM]
	dec a
	ld hl, TMHMMoves
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wTempTMHM], a
	ret

INCLUDE "data/moves/tmhm_moves.asm"
