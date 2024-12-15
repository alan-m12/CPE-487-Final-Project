# Switch Roulette


## Overview
This project features a two-player game that is similar to the world-famous Russian Roulette, but with NEXYS A7 switches instead of gunshots. When the button to start the game is pressed, 1 of the 16 switches on the NEXYS A7 Board, at random, will trigger a bomb when flipped! The other 15 are deemed "safe". Players take turns flipping one switch at a time, and the player who flips the bomb switch loses. Good luck!


## Concepts Used

- <ins>Finite State Machine</ins>: Both the bomb switch and the switches the players flip are fed into an FSM. The FSM has two different states that we call state A and state B. In state A, the seven-segment display on the NEXYS A7 Board displays the word "PLAY" to indicate that the game is in progress. Once the bomb switch is flipped, state B will be entered, where the seven-segment display will display the word "LOSE" to indicate that the player who flipped the last switch (bomb switch) has the lost the game. The FSM will stay in state B until all of the 16 switches are flipped back to "off" and the button is pressed. When that happens, it returns to state A and awaits a new game to be started.
  
- <ins>T Flip Flops</ins>: The counter.vhd file uses four T Flip Flops to generate a random four-bit number that will decide which of the 16 switches to make the bomb switch every round. Each T Flip Flop has three inputs (CLK, EN, and T) and one output (Q). Each of the outputs of the four different T Flip Flops corresponds to one of the bits in the random four-bit number, with T0 controlling the least significant bit and T3 controlling the most significant bit. 


## Getting it Working




## Inputs and Outputs


## Images and Videos


## Modifications

- **Blank Display to Start**: dffdv

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
- Wrote and Formatted Code
- Updated README (Concepts Used, Work Breakdown and Timeline)

