/* This file is a testing and learning example for using the gbdk library 
Author: Landon Reekstin
Sprite design: Christian Blaney
*/

#include <gb/gb.h>
#include <stdio.h>
#include <stdint.h>
#include "sprites.c"

#define SPRITE_SCROLL_SPEED 10

struct Sprite {
  unsigned char pixelData[16];
  uint8_t id;
  uint8_t initTile;
  uint8_t maxTile;
  uint8_t x;
  uint8_t y;
  uint8_t gravity;
  uint8_t velocity;
}

void change_sprite_tile(struct Sprite s);
void animate_sprite(struct Sprite s);
void translate_sprite(struct Sprite s);
void sprite_setup(struct Sprite s);

// ------------ Sprite functions ----------------

/** Changes current sprite tile to the next in the char array.
 *  @param maxTile  the max tile index of the sprite
 *  @param sprite   index of the sprite to change
*/
void change_sprite_tile(struct Sprite s) {
    uint8_t currentTile = get_sprite_tile(s.id);
    if (currentTile < s.maxTile - 1) {
        set_sprite_tile(s.id, ++currentTile);
    }
    else {
        set_sprite_tile(s.id, 0);
    }
}

/** Loops through sprite tiles for a given sprite.
 * @param sprite   index of the sprite to animate
*/
void animate_sprite(struct Sprite s) {
    for (uint8_t tileIdx = 0; tileIdx < s.maxTile; tileIdx++) {
        set_sprite_tile(s.id, tileIdx);
        delay(350);
    }
}

void translate_sprite(struct Sprite s) {
    
    switch(joypad()) {
        case J_LEFT:
            scroll_sprite(s.id, -1 * SPRITE_SCROLL_SPEED, 0);
            change_sprite_tile(s);
            break;
        case J_RIGHT:
            scroll_sprite(s.id, 1 * SPRITE_SCROLL_SPEED, 0);
            change_sprite_tile(s);
            break;
        case J_UP:
            scroll_sprite(s.id, 0, -1 * SPRITE_SCROLL_SPEED);
            change_sprite_tile(s);
            break;
        case J_DOWN:
            scroll_sprite(s.id, 0, 1 * SPRITE_SCROLL_SPEED);
            change_sprite_tile(s);
            break;
    }
    delay(100);
}

void sprite_setup(struct Sprite s) {   // in the future will pass in parameters to specify what sprite is being setup
    set_sprite_data(0, s.maxTile, s.pixelData);    // (initial tile, final tile, sprite char array)
    set_sprite_tile(0, s.initTile);                      // (sprite index, tile)
    move_sprite(0, s.x, s.y);                     // (sprite index, x, y)
    SHOW_SPRITES;
}


// ----------------- Map functions ----------------
/*

void map_setup() {  // in the future will pass in parameters to specify what map is being setup
    set_bkg_data(0, 7, maptilesname);
    set_bkg_tiles(0, 0, x, y, mapname);
    SHOW_BKG;
    DISPLAY_ON;
}

void scroll_map() {
    scroll_bkg(1, 0);
    delay(100);
}
*/

// ----------------- Sound functions ---------------
void sound_setup() {
    NR52_REG = 0x80; // enable sound
    NR50_REG = 0x77; // set volume for both channels to max
    NR51_REG = 0xFF; // select channels to use
}

void sample_sound() {
    // chanel 1 register 0, Frequency sweep settings
    // 7	Unused
    // 6-4	Sweep time(update rate) (if 0, sweeping is off)
    // 3	Sweep Direction (1: decrease, 0: increase)
    // 2-0	Sweep RtShift amount (if 0, sweeping is off)
    // 0001 0110 is 0x16, sweet time 1, sweep direction increase, shift ammount per step 110 (6 decimal)
    NR10_REG = 0x16; 

    // chanel 1 register 1: Wave pattern duty and sound length
    // Channels 1 2 and 4
    // 7-6	Wave pattern duty cycle 0-3 (12.5%, 25%, 50%, 75%), duty cycle is how long a quadrangular  wave is "on" vs "of" so 50% (2) is both equal.
    // 5-0 sound length (higher the number shorter the sound)
    // 01000000 is 0x40, duty cycle 1 (25%), wave length 0 (long)
    NR11_REG = 0x40;

    // chanel 1 register 2: Volume Envelope (Makes the volume get louder or quieter each "tick")
    // On Channels 1 2 and 4
    // 7-4	(Initial) Channel Volume
    // 3	Volume sweep direction (0: down; 1: up)
    // 2-0	Length of each step in sweep (if 0, sweeping is off)
    // NOTE: each step is n/64 seconds long, where n is 1-7	
    // 0111 0011 is 0x73, volume 7, sweep down, step length 3
    NR12_REG = 0x73;  

    // chanel 1 register 3: Frequency LSbs (Least Significant bits) and noise options
    // for Channels 1 2 and 3
    // 7-0	8 Least Significant bits of frequency (3 Most Significant Bits are set in register 4)
    NR13_REG = 0x00;   

    // chanel 1 register 4: Playback and frequency MSbs
    // Channels 1 2 3 and 4
    // 7	Initialize (trigger channel start, AKA channel INIT) (Write only)
    // 6	Consecutive select/length counter enable (Read/Write). When "0", regardless of the length of data on the NR11 register, sound can be produced consecutively.  When "1", sound is generated during the time period set by the length data contained in register NR11.  After the sound is ouput, the Sound 1 ON flag, at bit 0 of register NR52 is reset.
    // 5-3	Unused
    // 2-0	3 Most Significant bits of frequency
    // 1100 0011 is 0xC3, initialize, no consecutive, frequency = MSB + LSB = 011 0000 0000 = 0x300
    NR14_REG = 0xC3;
}

// ----------------- CPU functions ----------------

/** A less CPU intensive delay() using screen refreshes.
 * @param numloops Number of screen refreshes to perform.
 * */
void wait(UINT8 numloops){
    UINT8 i;
    for(i = 0; i < numloops; i++){
        wait_vbl_done();
    }     
}


// ----------------- Game functions ----------------

// main game event loop
void event_loop() {
    uint8_t currentSpriteIdx = 0;
    
    while(1) {

        translate_sprite(0);
        //animate_sprite(0);

    }
}

void main() {
    printf("My first \nGameBoy game!");
    sprite_setup();
    event_loop();
}