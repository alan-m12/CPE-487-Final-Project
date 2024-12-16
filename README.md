# Switch Roulette


## Overview
This project features a two-player game that is similar to the world-famous Russian Roulette, but with NEXYS A7 switches instead of gunshots. When the button to start the game is pressed, 1 of the 16 switches on the NEXYS A7 Board, at random, will trigger a bomb when flipped! The other 15 are deemed "safe". Players take turns flipping one switch at a time, and the player who flips the bomb switch loses. Good luck!


## Concepts Used

- <ins>Finite State Machine</ins>: Both the bomb switch and the switches the players flip are fed into an FSM. The FSM has two different states that we call state A and state B. In state A, the seven-segment display on the NEXYS A7 Board displays the word "PLAY" to indicate that the game is in progress. Once the bomb switch is flipped, state B will be entered, where the seven-segment display will display the word "LOSE" to indicate that the player who flipped the last switch (bomb switch) has the lost the game. The FSM will stay in state B until all of the 16 switches are flipped back to "off" and the button is pressed. When that happens, it returns to state A and awaits a new game to be started.


## Getting it Working




## Inputs and Outputs

### Inputs

- CLK
- Z
- START
- EN
- SWITCHES
- BTN0
- BTNU
- SW

### Outputs

- START
- BOMB_LOCATION
- DISP_EN
- SEGMENTS
- SCLK
- AN
- CURRENT_PLAYER

### Our Additions

<ins>Inputs</ins>
- 'BTNU': Initiates the 'hard' mode

<ins>Outputs</ins>
- 'START': A state of the FSM where the seven-segment display is blank


## Modifications

- <ins>Blank Display to Start</ins>: Originally, when the Vivado code was first uploaded to the NEXYS board, the display would already show "PLAY" even though a game had not been started. This would lead to confusion because players would start to flip switches, not knowing that a bomb switch had not been assigned yet. To solve this issue, we modified the code to make the seven-segment display blank upon uploading fresh code. This way, players will know a game would not start unless they push the button.

- <ins>All Switches to '0' to Play Again</ins>: Originally, after the bomb switch was found, the button could be clicked again to reassign a random bomb switch to any of the remaining unflipped switches. This would lead to new rounds being played without all 16 of the switches being used, which is not what we intended. To solve this issue, we implemented an 'if' statement that made sure that, when in state B, all of the switches were flipped back to '0' before the button could pressed to start a new game.

- <ins>Hard Mode</ins>: Originally, there was only one way to play the game, which was whoever flipped the singular bomb switch would lose. We have implemented a second mode, that we refer to as "hard mode", that is activated by pressing the top button (BTNU) rather than the middle button (BTNC). In this mode, there are 3 bomb switches instead of 1, which increases the chances of a player losing on their turn.


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

