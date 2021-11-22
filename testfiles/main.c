/* This file is a testing and learning example for using the gbdk library 
Author: Landon Reekstin
Sprite design: Christian Blaney
*/

#include <gb/gb.h>
#include <stdio.h>
#include <stdint.h>
#include "sprites.c"

#define SPRITE_SCROLL_SPEED 10


//------------------ Sprite functions ---------------------

/** Changes current sprite tile to the next in the char array.
 *  @param maxTile  the max tile index of the sprite
 *  @param sprite   index of the sprite to change
*/
void change_sprite_tile(uint8_t maxTile, int sprite) {
    uint8_t currentTile = get_sprite_tile(sprite);
    if (currentTile < maxTile - 1) {
        set_sprite_tile(sprite, ++currentTile);
    }
    else {
        set_sprite_tile(sprite, 0);
    }
}

/** Loops through sprite tiles for a given sprite.
 * @param sprite   index of the sprite to animate
*/
void animate_sprite(int sprite) {
    for (uint8_t tileIdx = 0; tileIdx < 5; tileIdx++) {
        set_sprite_tile(sprite, tileIdx);
        delay(350);
    }
}

void translate_sprite(int sprite) {
    
    switch(joypad()) {
        case J_LEFT:
            scroll_sprite(sprite, -1 * SPRITE_SCROLL_SPEED, 0);
            change_sprite_tile(5, 0);
            break;
        case J_RIGHT:
            scroll_sprite(sprite, 1 * SPRITE_SCROLL_SPEED, 0);
            change_sprite_tile(5, 0);
            break;
        case J_UP:
            scroll_sprite(sprite, 0, -1 * SPRITE_SCROLL_SPEED);
            change_sprite_tile(5, 0);
            break;
        case J_DOWN:
            scroll_sprite(sprite, 0, 1 * SPRITE_SCROLL_SPEED);
            change_sprite_tile(5, 0);
            break;
    }
    delay(100);
}

void sprite_setup() {
    set_sprite_data(0, 5, SmileToSurprised);    // (initial tile, final tile, sprite char array)
    set_sprite_tile(0, 0);                      // (sprite index, tile)
    move_sprite(0, 88, 78);                     // (sprite index, x, y)
    SHOW_SPRITES;
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