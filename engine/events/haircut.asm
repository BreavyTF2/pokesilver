BillsGrandfather:
	farcall SelectMonFromParty
	jr c, .cancel
	ld a, [wCurPartySpecies]
	ld [wScriptVar], a
	ld [wNamedObjectIndex], a
	call GetPokemonName
	jp CopyPokemonName_Buffer1_Buffer3

.cancel
	xor a
	ld [wScriptVar], a
	ret

OlderHaircutBrother:
	ld hl, HappinessData_OlderHaircutBrother
	jr HaircutOrGrooming

YoungerHaircutBrother:
	ld hl, HappinessData_YoungerHaircutBrother
	jr HaircutOrGrooming

DaisysGrooming:
	ld hl, HappinessData_DaisysGrooming
	; fallthrough

HaircutOrGrooming:
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call GetCurNickname
	call CopyPokemonName_Buffer1_Buffer3
	pop hl
	call Random
.loop
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop

.ok
	inc hl
	ld a, [hli]
	ld [wScriptVar], a
	ld c, [hl]
	call ChangeHappiness
	ret

.nope
	xor a
	ld [wScriptVar], a
	ret

.egg
	ld a, 1
	ld [wScriptVar], a
	ret

INCLUDE "data/events/happiness_probabilities.asm"

CopyPokemonName_Buffer1_Buffer3:
	ld hl, wStringBuffer1
	ld de, wStringBuffer3
	ld bc, NAME_LENGTH
	jp CopyBytes

IF DEF(_09_30)
	db $03
	ld hl, Overdump_HappinessData_DaisysGrooming
Overdump_HaircutOrGrooming:
	push hl
	farcall SelectMonFromParty
	pop hl
	jr c, .nope
	ld a, [wCurPartySpecies]
	cp EGG
	jr z, .egg
	push hl
	call $3AC7
	call Overdump_CopyPokemonName_Buffer1_Buffer3
	pop hl
	call $3102
.loop:	
	sub [hl]
	jr c, .ok
	inc hl
	inc hl
	inc hl
	jr .loop
	
.ok
	inc hl
	ldi a, [hl]
	ld [wScriptVar], a
	ld c, [hl]
	call $7D41
	ret
	
.nope
	xor a
	ld [wScriptVar], a
	ret

.egg
	ld a, 1
	ld [wScriptVar], a
	ret
	
Overdump_HappinessData_OlderHaircutBrother:
	db 30 percent,     2, HAPPINESS_OLDERCUT1 ; 30% chance
	db 50 percent + 1, 3, HAPPINESS_OLDERCUT2 ; 50% chance
	db -1,             4, HAPPINESS_OLDERCUT3 ; 20% chance

Overdump_HappinessData_YoungerHaircutBrother:
	db 60 percent + 1, 2, HAPPINESS_YOUNGCUT1 ; 60% chance
	db 30 percent,     3, HAPPINESS_YOUNGCUT2 ; 30% chance
	db -1,             4, HAPPINESS_YOUNGCUT3 ; 10% chance

Overdump_HappinessData_DaisysGrooming:
; BUG: Daisy's grooming doesn't always increase happiness (see docs/bugs_and_glitches.md)
	db -1,             2, HAPPINESS_GROOMING ; 99.6% chance

Overdump_CopyPokemonName_Buffer1_Buffer3:	
	ld hl, wStringBuffer1	; wStringBuffer1 = $CF87
	ld de, wStringBuffer3	; wStringBuffer3 = $CF9D
	ld bc, SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS	; SCENE_ELMSLAB_AIDE_GIVES_POKE_BALLS = $0006
	jp $317A
	
Overdump2_CopyPokemonName_Buffer1_Buffer3:
	nop
	jp $317A
ENDC
