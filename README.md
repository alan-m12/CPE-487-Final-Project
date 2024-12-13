# Switch Roulette


## Overview
This project features a two-player game that is similar to the world-famous Russian Roulette, but with NEXYS A7 switches instead of gunshots. When the button to start the game is pressed, 1 of the 16 switches on the NEXYS A7 Board, at random, will trigger a bomb when flipped! The other 15 are deemed "safe". Players take turns flipping one switch at a time, and the player who flips the bomb switch loses. Good luck!


## Concepts Used

- Finite State Machine: Both the bomb switch and the switches the players flip are fed into an FSM. The FSM has two different states that we call state A and state B. In state A, the seven-segment display on the NEXYS A7 Board displays the word "PLAY" to indicate that the game is in progress. Once the bomb switch is flipped, state B will be entered, where the seven-segment display will display the word "LOSE" to indicate that the player who flipped the last switch (bomb switch) has the lost the game. The FSM will stay in state B until all of the 16 switches are flipped back to "off". When that happens, it returns to state A and awaits a new game to be started.
  
- T Flip Flops: 
