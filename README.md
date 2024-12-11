# VGA-SnakeGameFinal
## By: Alberto Trejo, Jorge Armenteros, Larkin Tanner, Guillermo Ortega Vallejo

### <ins>Link to Demo:</ins> 
https://youtu.be/NK-NUK9Y8_Q 

### <ins>Project Overview:</ins>  
This is a single player video game based on the game “Snake” that is designed to be played with an FPGA board (Nexys A7) and a VGA display through Vivado.

### <ins>How to Run:</ins> 

To run our game, simply download the zip file with all .v source files and the .xdc constraints file. Then, open up Vivado and add all downloaded files into a project. Ensure to import the .v files as a source and the .xdc as a constraint. Connect an FPGA board to controll the game. Additionally, make sure to connect a VGA cable to both the FPGA and a monitor. Once you load up the game, you can start the game by clicking any of the directinal buttons in the FPGA. Eating an apple/bug increases the caterpillar's/snake's length. The left-most switch doubles as a color palatte switch and a game mode switch. When the switch is down, the game plays a snake (hard) mode. When you flip the switch, you enter caterpillar (easy) mode. The current score is displayed on a 7-segment display on the FPGA and will currently only display up to 69 points. If you collide with your body or a border, the screen will flash red and you will immediately restart with the score counter reseting to 0. If you want to stop the snake from moving, click the reset button. Currently, if you press the reset button while playing the game, the snake's length will be saved but the position will be reset to its initial state. If you wish to fully reset the game, simply collide with a border or your body and then press the reset button.

**Note:** 
- Nothing happens when you surpass 69 points, we just hard-coded the display
- The snake's length will reach it's maximum when you eat 18 apples or more... again, hard-code


### <ins>Bugs:</ins>

In a game with as many modules and components as this one, there are bound to be a few bugs. Ours are as follows:

- If you hit the reset button in snake mode, the screen's Hsync and Vsync are disrupted on the right side and offset by about 10 and 5 pixels respectively. If you switch back to caterpillar mode and hit reset, it corrects the issue. 

- In order to stop the snake’s movement after a game over, after crashing into a wall  then you must press the reset switch. In the current iteration, it is not possible to reset the score and therefore length of your snake with just “reset” switch

- A never ending death sequence occurs if you die while moving to the left. This is because when the snake dies in our game, it doesn’t stop moving until you hit the reset button. To fix this, either hit the reset button or hit a direction other than left.

- Very very rarely the apple can possibly generate within the body of the snake. This is also likely due to the order of the if statements in this section of code.

- The LEDS that light up on the FPGA board were just used for testing the score functionality. The correct score is displayed on the FPGA board above these.

### <ins>Overview of Code:</ins>
```
Snake - Top-most module connecting all smaller modules together wirking in conjunction with our constraints file

  TopModule - controls the BCD display counter for the score on the FPGA board. This module consists of anodes which
  controls the anodes of the display, a clock divider, a counter and a counter controller which updates the score on
  the display

  vga_display - responsible for the output on the VGA that corresponds to the snake and the features of the game we
  can see. It consists of the modules that   control the snake, apples, and game over conditions. The movement of the
  snake is all based around a clock divider which is adjusted with the difficulty switch to make the snake move slower
  or faster depending on the difficulty the player wants

  vga_display_2 - responsible for the Hsync and Vsync outputs of the VGA display and making sure that everything is
  displayed in the correct area of the screen in the playing area we desire

```
 
We did not need to use any test benches to test our game. Instead, we pushed and tested our code throught the FPGA and real-time inputs as we changed the corresponding outputs.  

### <ins>Project Inspiration:</ins>

- https://github.com/alaric4224/Snake

- https://www.youtube.com/watch?v=fCooCdQ-pSY
