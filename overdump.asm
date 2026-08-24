IF DEF(_09_30)

SECTION "Bank 03 Overdump", ROMX, BANK[3]

; partial overdump of KnowsMove.KnowsMoveText
	db "ています"
	prompt


SECTION "Bank 04 Overdump", ROMX, BANK[4]

; partial overdump of BugCatchingContestantEventFlagTable
	dw EVENT_BUG_CATCHING_CONTESTANT_10A

Overdump_ContestDropOffMons:
	ld hl, wPartyMon1HP
	ld a, [hli]
	or [hl]
	jr z, .fainted

	ld hl, wPartyCount
	ld a, 1
	ld [hli], a
	inc hl

	ld a, [hl]
	ld [wBugContestSecondPartySpecies], a

	ld [hl], -1
	xor a
	ld [wScriptVar], a
	ret

.fainted
	ld a, $1
	ld [wScriptVar], a
	ret

Overdump_ContestReturnMons:
	ld hl, wPartySpecies + 1
	ld a, [wBugContestSecondPartySpecies]
	ld [hl], a

	ld b, 1
.loop
	ld a, [hli]
	cp -1
	jr z, .done
	inc b
	jr .loop

.done
	ld a, b
	ld [wPartyCount], a
	ret


SECTION "Bank 09 Overdump", ROMX, BANK[9]

; partial overdump of Solarbeam
	checkobedience
	doturn
	skipsuncharge
	charge
	usedmovetext
	critical
	damagestats
	damagecalc
	stab
	damagevariation
	checkhit
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	checkfaint
	buildopponentrage
	kingsrock
	endmove

Overdump_Thunder:
	checkobedience
	usedmovetext
	doturn
	critical
	damagestats
	damagecalc
	thunderaccuracy
	checkhit
	effectchance
	stab
	damagevariation
	moveanim
	failuretext
	applydamage
	criticaltext
	supereffectivetext
	checkfaint
	buildopponentrage
	paralyzetarget
	endmove

Overdump_Teleport:
	checkobedience
	usedmovetext
	doturn
	teleport
	endmove

Overdump_BeatUp:
	checkobedience
	usedmovetext
	movedelay
	doturn
	startloop
	lowersub
	checkhit
	critical
	beatup
	damagecalc
	damagevariation
	clearmissdamage
	moveanimnosub
	failuretext
	applydamage
	criticaltext
	cleartext
	supereffectivetext
	checkfaint
	buildopponentrage
	endloop
	beatupfailtext
	raisesub
	kingsrock
	endmove

Overdump_DefenseCurl:
	checkobedience
	usedmovetext
	doturn
	defenseup
	curl
	lowersub
	statupanim
	raisesub
	statupmessage
	statupfailtext
	endmove


SECTION "Bank 0b Overdump", ROMX, BANK[11]

; this section contains data from at least 2 previous builds

; partial duplicate of ConvertBerriesToBerryJuice
	ret

	ld a, BERRY_JUICE
	ld [hl], a
	pop hl
	pop af
	ret

Overdump_ConvertBerriesToBerryJuice_partial:
.partyMonLoop
	push af
	push hl
	ld a, [hl]
	cp SHUCKLE
	jr nz, .loopMon
	ld bc, MON_ITEM
	add hl, bc
	ld a, [hl]
	cp BERRY
	jr z, .convertToJuice

.loopMon
	pop hl
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop af
	dec a
	jr nz, .partyMonLoop
	ret

.convertToJuice
	ld a, BERRY_JUICE
	ld [hl], a
	pop hl
	pop af
	ret


SECTION "Bank 0d Overdump", ROMX, BANK[13]

; partial overdump of SkipToBattleCommand
	dw wBattleScriptBufferAddress
	ret

Overdump_GetMoveAttr:
	push bc
	ld bc, MOVE_LENGTH
	call $3203 ; AddNTimes
	call Overdump_GetMoveByte
	pop bc
	ret

Overdump_GetMoveData:
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call $3203 ; AddNTimes
	ld a, BANK(Moves)
	jp FarCopyBytes

Overdump_GetMoveByte:
	ld a, BANK(Moves)
	jp $3188 ; GetFarByte

Overdump_DisappearUser:
	ld a, BANK(_DisappearUser)
	ld hl, $7e06 ; _DisappearUser
	rst FarCall
	ret

Overdump_AppearUserLowerSub:
	ld a, BANK(_AppearUserLowerSub)
	ld hl, $7e23 ; _AppearUserLowerSub
	rst FarCall
	ret

Overdump_AppearUserRaiseSub:
	ld a, BANK(_AppearUserRaiseSub)
	ld hl, $7e1b ; _AppearUserRaiseSub
	rst FarCall
	ret

ENDSECTION

ENDC
