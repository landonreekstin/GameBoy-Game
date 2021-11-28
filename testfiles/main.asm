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
	.globl _wait
	.globl _sample_sound
	.globl _sound_setup
	.globl _sprite_setup
	.globl _translate_sprite
	.globl _animate_sprite
	.globl _change_sprite_tile
	.globl _printf
	.globl _set_sprite_data
	.globl _wait_vbl_done
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
;main.c:36: void change_sprite_tile(uint8_t maxTile, int sprite) {
;	---------------------------------
; Function change_sprite_tile
; ---------------------------------
_change_sprite_tile::
	add	sp, #-4
;main.c:37: uint8_t currentTile = get_sprite_tile(sprite);
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
;main.c:38: if (currentTile < maxTile - 1) {
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
;main.c:39: set_sprite_tile(sprite, ++currentTile);
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
;main.c:39: set_sprite_tile(sprite, ++currentTile);
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
;main.c:42: set_sprite_tile(sprite, 0);
00107$:
;main.c:44: }
	add	sp, #4
	ret
;main.c:49: void animate_sprite(int sprite) {
;	---------------------------------
; Function animate_sprite
; ---------------------------------
_animate_sprite::
;main.c:50: for (uint8_t tileIdx = 0; tileIdx < 5; tileIdx++) {
	ld	c, #0x00
00104$:
	ld	a, c
	sub	a, #0x05
	ret	NC
;main.c:51: set_sprite_tile(sprite, tileIdx);
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
;main.c:52: delay(350);
	push	bc
	ld	de, #0x015e
	push	de
	call	_delay
	pop	hl
	pop	bc
;main.c:50: for (uint8_t tileIdx = 0; tileIdx < 5; tileIdx++) {
	inc	c
;main.c:54: }
	jr	00104$
;main.c:56: void translate_sprite(int sprite) {
;	---------------------------------
; Function translate_sprite
; ---------------------------------
_translate_sprite::
;main.c:58: switch(joypad()) {
	call	_joypad
	ld	c, e
;main.c:60: scroll_sprite(sprite, -1 * SPRITE_SCROLL_SPEED, 0);
	ldhl	sp,	#2
	ld	e, (hl)
;main.c:58: switch(joypad()) {
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
;main.c:59: case J_LEFT:
00101$:
;main.c:60: scroll_sprite(sprite, -1 * SPRITE_SCROLL_SPEED, 0);
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
;main.c:61: change_sprite_tile(5, 0);
	ld	de, #0x0000
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_change_sprite_tile
	add	sp, #3
;main.c:62: break;
	jr	00105$
;main.c:63: case J_RIGHT:
00102$:
;main.c:64: scroll_sprite(sprite, 1 * SPRITE_SCROLL_SPEED, 0);
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
;main.c:65: change_sprite_tile(5, 0);
	ld	de, #0x0000
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_change_sprite_tile
	add	sp, #3
;main.c:66: break;
	jr	00105$
;main.c:67: case J_UP:
00103$:
;main.c:68: scroll_sprite(sprite, 0, -1 * SPRITE_SCROLL_SPEED);
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
;main.c:69: change_sprite_tile(5, 0);
	ld	de, #0x0000
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_change_sprite_tile
	add	sp, #3
;main.c:70: break;
	jr	00105$
;main.c:71: case J_DOWN:
00104$:
;main.c:72: scroll_sprite(sprite, 0, 1 * SPRITE_SCROLL_SPEED);
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
;main.c:73: change_sprite_tile(5, 0);
	ld	de, #0x0000
	push	de
	ld	a, #0x05
	push	af
	inc	sp
	call	_change_sprite_tile
	add	sp, #3
;main.c:75: }
00105$:
;main.c:76: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
;main.c:77: }
	ret
;main.c:79: void sprite_setup() {   // in the future will pass in parameters to specify what sprite is being setup
;	---------------------------------
; Function sprite_setup
; ---------------------------------
_sprite_setup::
;main.c:80: set_sprite_data(0, 5, SmileToSurprised);    // (initial tile, final tile, sprite char array)
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
;main.c:83: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:84: }
	ret
;main.c:87: void sound_setup() {
;	---------------------------------
; Function sound_setup
; ---------------------------------
_sound_setup::
;main.c:88: NR52_REG = 0x80; // enable sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:89: NR50_REG = 0x77; // set volume for both channels to max
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;main.c:90: NR51_REG = 0xFF; // select channels to use
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:91: }
	ret
;main.c:93: void sample_sound() {
;	---------------------------------
; Function sample_sound
; ---------------------------------
_sample_sound::
;main.c:100: NR10_REG = 0x16; 
	ld	a, #0x16
	ldh	(_NR10_REG + 0), a
;main.c:107: NR11_REG = 0x40;
	ld	a, #0x40
	ldh	(_NR11_REG + 0), a
;main.c:116: NR12_REG = 0x73;  
	ld	a, #0x73
	ldh	(_NR12_REG + 0), a
;main.c:121: NR13_REG = 0x00;   
	xor	a, a
	ldh	(_NR13_REG + 0), a
;main.c:130: NR14_REG = 0xC3;
	ld	a, #0xc3
	ldh	(_NR14_REG + 0), a
;main.c:131: }
	ret
;main.c:138: void wait(UINT8 numloops){
;	---------------------------------
; Function wait
; ---------------------------------
_wait::
;main.c:140: for(i = 0; i < numloops; i++){
	ld	c, #0x00
00103$:
	ld	a, c
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;main.c:141: wait_vbl_done();
	call	_wait_vbl_done
;main.c:140: for(i = 0; i < numloops; i++){
	inc	c
;main.c:143: }
	jr	00103$
;main.c:149: void event_loop() {
;	---------------------------------
; Function event_loop
; ---------------------------------
_event_loop::
;main.c:152: while(1) {
00102$:
;main.c:154: translate_sprite(0);
	ld	de, #0x0000
	push	de
	call	_translate_sprite
	pop	hl
;main.c:158: }
	jr	00102$
;main.c:160: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:161: printf("My first \nGameBoy game!");
	ld	de, #___str_0
	push	de
	call	_printf
	pop	hl
;main.c:162: sprite_setup();
	call	_sprite_setup
;main.c:163: event_loop();
;main.c:164: }
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
