;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12539 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _event_loop
	.globl _sprite_setup
	.globl _translate_sprite
	.globl _animate_sprite
	.globl _change_sprite_tile
	.globl _printf
	.globl _set_sprite_data
	.globl _joypad
	.globl _delay
	.globl _SmileToSurprised
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_SmileToSurprised::
	.ds 96
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:20: void change_sprite_tile(uint8_t maxTile, int sprite) {
;	---------------------------------
; Function change_sprite_tile
; ---------------------------------
_change_sprite_tile::
	add	sp, #-4
;main.c:21: uint8_t currentTile = get_sprite_tile(sprite);
	ldhl	sp,	#7
	ld	a, (hl)
	ldhl	sp,	#0
	ld	(hl), a
	ld	l, (hl)
	ld	bc, #_shadow_OAM+0
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
	inc	hl
	inc	hl
	ld	a, (hl)
	ldhl	sp,	#1
	ld	(hl), a
;main.c:22: if (currentTile < maxTile - 1) {
	ldhl	sp,	#6
	ld	c, (hl)
	ld	b, #0x00
	dec	bc
	ldhl	sp,	#1
	ld	a, (hl+)
	ld	(hl+), a
	xor	a, a
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00114$
	bit	7, d
	jr	NZ, 00115$
	cp	a, a
	jr	00115$
00114$:
	bit	7, d
	jr	Z, 00115$
	scf
00115$:
	jr	NC, 00102$
;main.c:23: set_sprite_tile(sprite, ++currentTile);
	ldhl	sp,	#1
;c:/gbdk/include/gb/gb.h:1326: shadow_OAM[nb].tile=tile;
	ld	a, (hl-)
	ld	c, a
	inc	c
	ld	de, #_shadow_OAM+0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:23: set_sprite_tile(sprite, ++currentTile);
	jr	00107$
00102$:
;c:/gbdk/include/gb/gb.h:1326: shadow_OAM[nb].tile=tile;
	ldhl	sp,	#0
	ld	l, (hl)
	ld	h, #0x00
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), #0x00
;main.c:26: set_sprite_tile(sprite, 0);
00107$:
;main.c:28: }
	add	sp, #4
	ret
;main.c:33: void animate_sprite(int sprite) {
;	---------------------------------
; Function animate_sprite
; ---------------------------------
_animate_sprite::
;main.c:34: for (uint8_t tileIdx = 0; tileIdx < 5; tileIdx++) {
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x05
	ret	NC
;main.c:35: set_sprite_tile(sprite, tileIdx);
	ldhl	sp,	#2
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1326: shadow_OAM[nb].tile=tile;
	ld	l, b
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
	inc	hl
	inc	hl
	ld	(hl), c
;main.c:36: delay(350);
	push	bc
	ld	de, #0x015e
	push	de
	call	_delay
	pop	hl
	pop	bc
;main.c:34: for (uint8_t tileIdx = 0; tileIdx < 5; tileIdx++) {
	inc	c
;main.c:38: }
	jr	00104$
;main.c:40: void translate_sprite(int sprite) {
;	---------------------------------
; Function translate_sprite
; ---------------------------------
_translate_sprite::
;main.c:42: switch(joypad()) {
	call	_joypad
	ld	c, e
;main.c:44: scroll_sprite(sprite, -1 * SPRITE_SCROLL_SPEED, 0);
	ldhl	sp,	#2
	ld	e, (hl)
;main.c:42: switch(joypad()) {
	ld	a, c
	dec	a
	jr	Z, 00102$
	ld	a,c
	cp	a,#0x02
	jr	Z, 00101$
	cp	a,#0x04
	jr	Z, 00103$
	sub	a, #0x08
	jr	Z, 00104$
	jr	00105$
;main.c:43: case J_LEFT:
00101$:
;main.c:44: scroll_sprite(sprite, -1 * SPRITE_SCROLL_SPEED, 0);
;c:/gbdk/include/gb/gb.h:1415: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:/gbdk/include/gb/gb.h:1416: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0xf6
	ld	(hl), a
;main.c:45: change_sprite_tile(5, 0);
	ld	de, #0x0000
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_change_sprite_tile
	add	sp, #3
;main.c:46: break;
	jr	00105$
;main.c:47: case J_RIGHT:
00102$:
;main.c:48: scroll_sprite(sprite, 1 * SPRITE_SCROLL_SPEED, 0);
;c:/gbdk/include/gb/gb.h:1415: OAM_item_t * itm = &shadow_OAM[nb];
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	ld	de, #_shadow_OAM
	add	hl, de
;c:/gbdk/include/gb/gb.h:1416: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	ld	(hl+), a
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl), a
;main.c:49: change_sprite_tile(5, 0);
	ld	de, #0x0000
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_change_sprite_tile
	add	sp, #3
;main.c:50: break;
	jr	00105$
;main.c:51: case J_UP:
00103$:
;main.c:52: scroll_sprite(sprite, 0, -1 * SPRITE_SCROLL_SPEED);
;c:/gbdk/include/gb/gb.h:1415: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:/gbdk/include/gb/gb.h:1416: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	add	a, #0xf6
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
;main.c:53: change_sprite_tile(5, 0);
	ld	de, #0x0000
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_change_sprite_tile
	add	sp, #3
;main.c:54: break;
	jr	00105$
;main.c:55: case J_DOWN:
00104$:
;main.c:56: scroll_sprite(sprite, 0, 1 * SPRITE_SCROLL_SPEED);
;c:/gbdk/include/gb/gb.h:1415: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, #0x00
;	spillPairReg hl
;	spillPairReg hl
	add	hl, hl
	add	hl, hl
	add	hl, bc
;c:/gbdk/include/gb/gb.h:1416: itm->y+=y, itm->x+=x;
	ld	a, (hl)
	add	a, #0x0a
	ld	(hl+), a
	ld	a, (hl)
	ld	(hl), a
;main.c:57: change_sprite_tile(5, 0);
	ld	de, #0x0000
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_change_sprite_tile
	add	sp, #3
;main.c:59: }
00105$:
;main.c:60: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;main.c:61: }
	ret
;main.c:63: void sprite_setup() {
;	---------------------------------
; Function sprite_setup
; ---------------------------------
_sprite_setup::
;main.c:64: set_sprite_data(0, 5, SmileToSurprised);    // (initial tile, final tile, sprite char array)
	ld	de, #_SmileToSurprised
	push	de
	ld	hl, #0x500
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1326: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1399: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1400: itm->y=y, itm->x=x;
	ld	a, #0x4e
	ld	(hl+), a
	ld	(hl), #0x58
;main.c:67: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:68: }
	ret
;main.c:74: void event_loop() {
;	---------------------------------
; Function event_loop
; ---------------------------------
_event_loop::
;main.c:77: while(1) {
00102$:
;main.c:79: translate_sprite(0);
	ld	de, #0x0000
	push	de
	call	_translate_sprite
	pop	hl
;main.c:83: }
	jr	00102$
;main.c:85: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:86: printf("My first \nGameBoy game!");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;main.c:87: sprite_setup();
	call	_sprite_setup
;main.c:88: event_loop();
;main.c:89: }
	jp	_event_loop
___str_0:
	.ascii "My first "
	.db 0x0a
	.ascii "GameBoy game!"
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__SmileToSurprised:
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x5a	; 90	'Z'
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xc3	; 195
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x66	; 102	'f'
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x24	; 36
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x66	; 102	'f'
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x66	; 102	'f'
	.db #0x81	; 129
	.db #0xff	; 255
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0xa5	; 165
	.db #0x7e	; 126
	.db #0x81	; 129
	.db #0x7e	; 126
	.db #0x99	; 153
	.db #0x7e	; 126
	.db #0x5a	; 90	'Z'
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x00	; 0
	.area _CABS (ABS)
