# VGA-SnakeGameFinal
## By: Alberto Trejo, Jorge Armenteros, Larkin Tanner, Guillermo Ortega Vallejo

### Link to Demo: 
https://youtu.be/NK-NUK9Y8_Q 

### Project Overview: 
This is a single player video game based on the game “Snake” that is designed to be compatible with an FPGA board and a VGA display and a computer that can run Vivado.

### How to Run:

To run our game, simply download each of the attached sources in the sources and the constraints file onto a computer that can run Vivado. You must then open the file and import each of the files as a source or constraint respectively. Connect a VGA display to display the game. You must connect an FPGA board to use as your controller for our game. To start the game, simply upload the code to the FPGA board and hit any of the buttons to choose your direction. Once the snake begins to move, use the arrow buttons in the direction the snake moves in. As you pick up apples, which are discerned by the red or brown colored blocks that reappear once you run into them, the score counter on the FPGA increases. Running into yourself or the walls will cause a red game over screen to display. You must then hit the reset switch to restart the game and set the score back to 0! Once you hit 18 points, you have reached the highest length, but you can keep playing and the score will continue to update until you reach a score of 69. Use the difficulty switch furthest to the left to change between snake mode and caterpillar mode. Not only does this change the palette of the game, but it also increases the speed and therefore difficulty. 


### Bugs:

In a game with as many modules and components as this one, there are bound to be a few bugs. Ours are as follows:

. If you hit the reset button in snake mode, the screen's Hsync and Vsync are messed up on the right side and offset by about 10 and 5 pixels respectively. If you switch back to caterpillar mode and hit reset, it corrects the issue. 

. In order to stop the snake’s movement after a game over, after crashing into a wall  then you must press the reset switch. In the current iteration, it is not possible to reset the score and therefore length of your snake with just “reset” switch

. A never ending death sequence occurs if you die while moving to the left. This is because when the snake dies in our game, it doesn’t stop moving until you hit the reset button. To fix this, either hit the reset button or hit a direction other than left.

. Very very rarely the apple can possibly generate within the body of the snake. This is also likely due to the order of the if statements in this section of code.

. The LEDS that light up on the FPGA board were just used for testing the score functionality. The correct score is displayed on the FPGA board above these.

### Overview of Code:

The very top module is called Snake. This way the user knows to set this module with the highest priority in Vivado to run it. Snake Game calls three modules.
 
TopModule controls the BCD display counter for the score on the FPGA board. This module consists of anodes which controls the anodes of the display, a clock divider, a counter and a counter controller which updates the score on the display. 
VGA Display  is responsible for the output on the VGA that corresponds to the snake and the features of the game we can see. It consists of the modules that control the snake, apples, and game over conditions. The movement of the snake is all based around a clock divider which is adjusted with the difficulty switch to make the snake move slower or faster depending on the difficulty the player wants. 
VGA_display_2 is responsible for the Hsync and Vsync outputs of the VGA display and making sure that everything is displayed in the correct area of the screen in the playing area we desire. 
Buttons allow us to use the built in buttons on the FPGA board alongside a debouncer to control our snake and the reset of the game.

We did not need to use any test benches to test our game. What was more beneficial to us was testing different states and outputs such as endgame and score by creating LED outputs on the FPGA board to temporarily see if these features were working as intended.  

### Project Inspiration:

https://github.com/alaric4224/Snake 
https://www.youtube.com/watch?v=fCooCdQ-pSY
