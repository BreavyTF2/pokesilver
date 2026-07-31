ReanchorMap::
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; aka BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate
	call HDMATransferTilemapAndAttrmap_Menu
	call LoadFonts_NoOAMUpdate

	pop af
	rst Bankswitch
	ret

CloseText::
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a

	call .CloseText

	pop af
	ldh [hOAMUpdate], a
	ret

.CloseText:
	call ClearWindowData
	xor a
	ldh [hBGMapMode], a
	call LoadOverworldTilemapAndAttrmapPals
	call HDMATransferTilemapAndAttrmap_Menu
	xor a
	ldh [hBGMapMode], a
	call SafeUpdateSprites
	ld a, $90
	ldh [hWY], a
	farcall LoadWalkingSpritesGFX
	call UpdatePlayerSprite
	ld hl, wUnusedReanchorBGMapFlags
	res UNUSED_REANCHOR_BG_MAP_7, [hl]
	call ResetBGWindow
	ret

OpenText::
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; aka BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate ; anchor bgmap
	call SpeechTextbox
	call HDMATransferTilemapAndAttrmap_Menu ; transfer bgmap
	call LoadFonts_NoOAMUpdate ; load font
	pop af
	rst Bankswitch

	ret

HDMATransferTilemapAndAttrmap_Menu::
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a

	call CGBOnly_CopyTilemapAtOnce

	pop af
	ldh [hOAMUpdate], a
	ret

SafeUpdateSprites::
IF DEF(_09_29)
	call UpdateSprites
ENDC
	ldh a, [hOAMUpdate]
	push af
	ldh a, [hBGMapMode]
	push af
	xor a
IF DEF(_09_30) || DEF(_10_06) || DEF(_REV0) || DEF(_REV1)
	ldh [hBGMapMode], a
	ld a, $1
	ldh [hOAMUpdate], a

	call UpdateSprites

	xor a
	ldh [hOAMUpdate], a
ELIF DEF(_09_29)
	ldh [hOAMUpdate], a
	ldh [hBGMapMode], a
ENDC
	call DelayFrame
	pop af
	ldh [hBGMapMode], a
	pop af
	ldh [hOAMUpdate], a
	ret

SetCarryFlag:: ; unreferenced
	scf
	ret
