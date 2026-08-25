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


SECTION "Bank 0f Overdump", ROMX, BANK[15]

; partial overdump of BattleCommandPointers
	db HIGH(BattleCommand_HappinessPower)
	dw BattleCommand_Present
	dw BattleCommand_DamageCalc
	dw BattleCommand_FrustrationPower
	dw BattleCommand_Safeguard
	dw BattleCommand_CheckSafeguard
	dw BattleCommand_GetMagnitude
	dw BattleCommand_BatonPass
	dw BattleCommand_Pursuit
	dw BattleCommand_ClearHazards
	dw BattleCommand_HealMorn
	dw BattleCommand_HealDay
	dw BattleCommand_HealNite
	dw BattleCommand_HiddenPower
	dw BattleCommand_StartRain
	dw BattleCommand_StartSun
	dw BattleCommand_AttackUp
	dw BattleCommand_DefenseUp
	dw BattleCommand_SpeedUp
	dw BattleCommand_SpecialAttackUp
	dw BattleCommand_SpecialDefenseUp
	dw BattleCommand_AccuracyUp
	dw BattleCommand_EvasionUp
	dw BattleCommand_AttackUp2
	dw BattleCommand_DefenseUp2
	dw BattleCommand_SpeedUp2
	dw BattleCommand_SpecialAttackUp2
	dw BattleCommand_SpecialDefenseUp2
	dw BattleCommand_AccuracyUp2
	dw BattleCommand_EvasionUp2
	dw BattleCommand_AttackDown
	dw BattleCommand_DefenseDown
	dw BattleCommand_SpeedDown
	dw BattleCommand_SpecialAttackDown
	dw BattleCommand_SpecialDefenseDown
	dw BattleCommand_AccuracyDown
	dw BattleCommand_EvasionDown
	dw BattleCommand_AttackDown2
	dw BattleCommand_DefenseDown2
	dw BattleCommand_SpeedDown2
	dw BattleCommand_SpecialAttackDown2
	dw BattleCommand_SpecialDefenseDown2
	dw BattleCommand_AccuracyDown2
	dw BattleCommand_EvasionDown2
	dw BattleCommand_StatUpMessage
	dw BattleCommand_StatDownMessage
	dw BattleCommand_StatUpFailText
	dw BattleCommand_StatDownFailText
	dw BattleCommand_EffectChance
	dw BattleCommand_StatDownAnim
	dw BattleCommand_StatUpAnim
	dw BattleCommand_SwitchTurn
	dw BattleCommand_FakeOut
	dw BattleCommand_BellyDrum
	dw BattleCommand_PsychUp
	dw BattleCommand_Rage
	dw BattleCommand_DoubleFlyingDamage
	dw BattleCommand_DoubleUndergroundDamage
	dw BattleCommand_MirrorCoat
	dw BattleCommand_CheckFutureSight
	dw BattleCommand_FutureSight
	dw BattleCommand_DoubleMinimizeDamage
	dw BattleCommand_SkipSunCharge
	dw BattleCommand_ThunderAccuracy
	dw BattleCommand_Teleport
	dw BattleCommand_BeatUp
	dw BattleCommand_RageDamage
	dw BattleCommand_ResetTypeMatchup
	dw BattleCommand_AllStatsUp
	dw BattleCommand_BideFailText
	dw BattleCommand_RaiseSubNoAnim
	dw BattleCommand_LowerSubNoAnim
	dw BattleCommand_BeatUpFailText
	dw BattleCommand_ClearMissDamage
	dw BattleCommand_MoveDelay
	dw BattleCommand_MoveAnim
	dw BattleCommand_TriStatusChance
	dw BattleCommand_SuperEffectiveLoopText
	dw BattleCommand_StartLoop
	dw BattleCommand_Curl


SECTION "Bank 25 Overdump", ROMX, BANK[37]

Overdump_CmdQueue_StoneTable_partial:
	dw $37b4 ; HandleStoneQueue
	jr c, .fall_down_hole

.next
	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	dec a
	jr nz, @ - 50
	ret

.fall_down_hole
	pop af
	ret

Overdump_TalkToTrainerScript:
	faceplayer
	trainerflagaction CHECK_FLAG
	iftrue Overdump_AlreadyBeatenTrainerScript
	loadtemptrainer
	encountermusic
	sjump Overdump_StartBattleWithMapTrainerScript

Overdump_SeenByTrainerScript:
	loadtemptrainer
	encountermusic
	showemote EMOTE_SHOCK, LAST_TALKED, 30
	callasm TrainerWalkToPlayer
	applymovementlasttalked wMovementBuffer
	writeobjectxy LAST_TALKED
	faceobject PLAYER, LAST_TALKED
	sjump Overdump_StartBattleWithMapTrainerScript

Overdump_StartBattleWithMapTrainerScript:
	opentext
	trainertext TRAINERTEXT_SEEN
	waitbutton
	closetext
	loadtemptrainer
	startbattle
	reloadmapafterbattle
	trainerflagaction SET_FLAG
	loadmem wRunningTrainerBattleScript, -1

Overdump_AlreadyBeatenTrainerScript:
	scripttalkafter


SECTION "Bank 2d Overdump", ROMX, BANK[45]

; partial overdump of CianwoodLugiaSpeechHouse_MapEvents
	db -1


SECTION "Bank 2f Overdump", ROMX, BANK[47]

MACRO object_event_overdump
	db \3, \2 + 4, \1 + 4, \4
	dn \6, \5
	db \7, \8
	dn \9, \<10>
	db \<11>
	dw \<12>, \<13>
ENDM

; partial overdump of OaksLab_MapEvents
	db 0
	dw $7c02, -1
	object_event_overdump  8,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, $7c05, -1
	object_event_overdump  1,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, $7c08, -1

ENDSECTION

ENDC
