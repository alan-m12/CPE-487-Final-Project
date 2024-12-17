# Switch Roulette


## Overview
This project features a two-player game that is similar to the world-famous Russian Roulette, but with NEXYS A7 switches instead of gunshots. When the button to start the game is pressed, 1 of the 16 switches on the NEXYS A7 Board, at random, will trigger a bomb when flipped! The other 15 are deemed "safe". Players take turns flipping one switch at a time, and the player who flips the bomb switch loses. Good luck!



https://github.com/user-attachments/assets/e22566fb-7704-4349-8af8-d9e90414078c



## Concepts Used

- <ins>Finite State Machine</ins>: Both the bomb switch and the switches the players flip are fed into an FSM. The FSM has two different states that we call state A and state B. In state A, the seven-segment display on the NEXYS A7 Board displays the word "PLAY" to indicate that the game is in progress. Once the bomb switch is flipped, state B will be entered, where the seven-segment display will display the word "LOSE" to indicate that the player who flipped the last switch (bomb switch) has the lost the game. The FSM will stay in state B until all of the 16 switches are flipped back to "off" and the button is pressed. When that happens, it returns to state A and awaits a new game to be started.


## Getting it Working

-To begin the project we found some starter code from the following site: https://www.instructables.com/Minesweeper/. It was the basic roullete game that randomly set a bomb and had the Play/Lose States. 
-The first first thing that was done from there was transforming the code and introducing a constraint file thatwould work for the NEXYS A7 board 

-In order to run this program, you must download the 4 source files above(roulette.vhd, BC_DEC.vhd, clk_div.vhd, my_fsm.vhd) then add them as sources in a new Vivado project. Then download the contraint file (roulette.xdc) and move it into that same project as a constraint file. Then run synthesis and implementation and then generate the bitstream and hit program device.

## Inputs and Outputs

- Roulette.vhd (Top Level)
  
INPUTS:

CLK100MHZ - Main system clock operating at 100MHz

SW[15:0]  - Array of 16 switches players use to make moves

BTN0      - Button to start/reset single-player mode 

BTNU      - Button to start/reset multiplayer mode

OUTPUTS:

SEGMENTS[7:0] - Controls the segments of each digit display (a-g + decimal point)

AN[7:0]       - Controls which digit position is active (digit select)

LED[1:0]      - Status indicators (01=safe move, 10=bomb hit)

- my_fsm.vhd (Game Controller)
  
INPUTS:

SWITCHES[15:0] - Input from board switches for gameplay

BTN0, BTNU     - Input buttons for mode selection/reset

CLK            - System clock input

OUTPUTS:

Z              - Indicates game over state (0=playing, 1=game over)

START          - Indicates game start state (1=start screen)

BOMB_LOCATION  - Current bomb position for single player mode

CURRENT_PLAYER - Tracks current player's turn (0=player1, 1=player2)

LED_STATE      - Controls LED display patterns (01=safe, 10=bomb hit)

- BC_DEC.vhd (Display Controller)
  
INPUTS:

CLK     - System clock input for timing

Z       - Game over state indicator from FSM

START   - Game start state indicator from FSM

OUTPUTS:

DISP_EN[7:0]   - Controls which display digits are active 

SEGMENTS[7:0]   - Controlls segment patterns for displaying "PLAY" or "LOSE"

- clk_div.vhd (Clock Divider)
  
INPUTS:

clk     - Input clock that needs to be divided

OUTPUTS:

sclk    - Slowed clock output for display refresh timing

### Our Additions

<ins>Inputs</ins>
- 'BTNU': Initiates the 'hard' mode

<ins>Outputs</ins>
- 'START': A state of the FSM where the seven-segment display is blank


## Modifications

- <ins>Formating</ins>: The bigesst modification between the starter code and our code now is the consolidation of the jobs from other files into my_fsm.vhd specifically the random generation being a LFSR

- <ins>Blank Display to Start</ins>: Originally, when the Vivado code was first uploaded to the NEXYS board, the display would already show "PLAY" even though a game had not been started. This would lead to confusion because players would start to flip switches, not knowing that a bomb switch had not been assigned yet. To solve this issue, we modified the code to make the seven-segment display blank upon uploading fresh code. This way, players will know a game would not start unless they push the button.

- <ins>All Switches to '0' to Play Again</ins>: Originally, after the bomb switch was found, the button could be clicked again to reassign a random bomb switch to any of the remaining unflipped switches. This would lead to new rounds being played without all 16 of the switches being used, which is not what we intended. To solve this issue, we implemented an 'if' statement that made sure that, when in state B, all of the switches were flipped back to '0' before the button could pressed to start a new game.

- <ins>Multi Bomb</ins>: Originally, there was only one way to play the game, which was whoever flipped the singular bomb switch would lose. We have implemented a second mode, that we refer to as "Multi-Bomb", that is activated by pressing the top button (BTNU) rather than the middle button (BTNC). In this mode, there are 3 bomb switches instead of 1, which also only causes a player to lose if they hit 2 out of 3 of the bomb switches.

- <ins>LED Indicators</ins>: To create a bit offeed backforboth modes, we made it so LEDs R11 and N15 flash green when a safe switch is flipped and red when a bomb switch is flipped respectively and blinks red rapidly when the Lose state is entered until a game reset occurs.

<ins>Multi Bomb mode demo</ins>


https://github.com/user-attachments/assets/6ff0c5b4-377d-461f-8d55-38662a485430


## Images and Videos

This image shows the board in its initial 'START' state, when the display is blank:
![Final Project Blank Display](https://github.com/user-attachments/assets/b0256e60-ddd2-4374-9522-27cbc46bf67c)


This image shows the board when a game is in progress:
![Final Project Play Display](https://github.com/user-attachments/assets/72108314-9643-4efd-a18b-7141cb05bde4)


This image shows the board when a player has flipped the bomb switch:
![Final Project Lose Display](https://github.com/user-attachments/assets/564c3c25-443c-47ed-9731-cf7fc379a0a0)

This video shows that a new game cannot be started unless all switches are flipped to '0' and the button is pressed (our modification):
https://github.com/user-attachments/assets/536edbbc-48b2-4180-84a0-73cd470e7dec





## Work Breakdown and Timeline

### Responsibilities

- Alan Manjarrez: Most Programming, Hardware Integration
- Dylan Ramcharitar: Some Programming, README Documentation

### Timeline

<ins>11/30/24</ins>
- Brainstormed project ideas
- Conducted extensive research on idea
- Found starter code
- Assessed materials
- Established GitHub Repository and updated README (Overview)


<ins>12/8/24 to 12/14/24</ins>
- Formatted started code to work on NEXYS A7
- Updated README (Concepts Used, Work Breakdown and Timeline)


<ins>12/15/24 to 12/16/24</ins>
- Finalized formatting and added our modifications to code
- Updated README (Getting it Working, Inputs and Outputs, Modifications, Work Breakdown and Timeline)
- Created presentation

