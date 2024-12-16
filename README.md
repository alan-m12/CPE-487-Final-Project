# Switch Roulette


## Overview
This project features a two-player game that is similar to the world-famous Russian Roulette, but with NEXYS A7 switches instead of gunshots. When the button to start the game is pressed, 1 of the 16 switches on the NEXYS A7 Board, at random, will trigger a bomb when flipped! The other 15 are deemed "safe". Players take turns flipping one switch at a time, and the player who flips the bomb switch loses. Good luck!


## Concepts Used

- <ins>Finite State Machine</ins>: Both the bomb switch and the switches the players flip are fed into an FSM. The FSM has two different states that we call state A and state B. In state A, the seven-segment display on the NEXYS A7 Board displays the word "PLAY" to indicate that the game is in progress. Once the bomb switch is flipped, state B will be entered, where the seven-segment display will display the word "LOSE" to indicate that the player who flipped the last switch (bomb switch) has the lost the game. The FSM will stay in state B until all of the 16 switches are flipped back to "off" and the button is pressed. When that happens, it returns to state A and awaits a new game to be started.
  
- <ins>T Flip Flops</ins>: The counter.vhd file uses four T Flip Flops to generate a random four-bit number that will decide which of the 16 switches to make the bomb switch every round. Each T Flip Flop has three inputs (CLK, EN, and T) and one output (Q). Each of the outputs of the four different T Flip Flops corresponds to one of the bits in the random four-bit number, with T0 controlling the least significant bit and T3 controlling the most significant bit. 


## Getting it Working




## Inputs and Outputs

### Inputs

- CLK
- Z
- START
- EN
- SWITCHES
- BTN0
- R_N
- SW
- T

### Outputs

- START
- BOMB_LOCATION
- DISP_EN
- SEGMENTS
- SCLK
- R_N
- X
- CURRENT_PLAYER
- AN
- Q

### Our Additions

<ins>Inputs</ins>
- xxxxxxx

<ins>Outputs</ins>
- 'START': A state of the FSM where the seven-segment display is blank


## Images and Videos

![Final Project Blank Display](https://github.com/user-attachments/assets/b0256e60-ddd2-4374-9522-27cbc46bf67c | width = 100)



## Modifications

- <ins>Blank Display to Start</ins>: Originally, when the Vivado code was first uploaded to the NEXYS board, the display would already show "PLAY" even though a game had not been started. This would lead to confusion because players would start to flip switches, not knowing that a bomb switch had not been assigned yet. To solve this issue, we modified the code to make the seven-segment display blank upon uploading fresh code. This way, players will know a game would not start unless they push the button.

- <ins>All Switches to '0' to Play Again</ins>: Originally, after the bomb switch was found, the button could be clicked again to reassign a random bomb switch to any of the remaining unflipped switches. This would lead to new rounds being played without all 16 of the switches being used, which is not what we intended. To solve this issue, we implemented an 'if' statement that made sure that, when in state B, all of the switches were flipped back to '0' before the button could pressed to start a new game.


## Work Breakdown and Timeline

### Responsibilities

- Alan Manjarrez: Most Programming, Hardware Integration
- Dylan Ramcharitar: Some Programming, README Documentation

### Timeline

<ins>12/7/24</ins>
- Brainstormed project ideas
- Conducted extensive research on idea
- Found starter code
- Assessed materials
- Established GitHub Repository and updated README (Overview)


<ins>12/13/24</ins>
- Formatted started code to work on NEXYS A7
- Updated README (Concepts Used, Work Breakdown and Timeline)


<ins>12/15/24</ins>
- Finalized formatting and added our modifications to code
- Updated README (Getting it Working, Inputs and Outputs, Modifications, Work Breakdown and Timeline)
- Created presentation

