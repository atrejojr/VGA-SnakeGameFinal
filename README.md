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

- In order to stop the snake’s movement after a game over, you must click the reset button. However, this will not reset the score counter and since the snake's size depends on this counter, you should see the snake keep its size. To fix this, cause a self/border collision and THEN click reset. 

- A never ending death sequence occurs if you die while moving to the left since we save the last movement input. Since our snake's body is to the left of the head, you will constantly be causign a body collision leading to an endgame state every other clock cycle. To fix this, either hit the reset button or hit any other direction other than left.

- Very very rarely the apple can possibly generate within the body of the snake. This is also likely due to the order of the if statements in this section of code but could be fixed if we defined the snake's body inside the apple generating module.

- The LEDS that light up on the FPGA board were just used for testing the score functionality. Not a bug, but we wanted to note that the LEDs and the 7-segment display output the same numbers.

### <ins>Overview of Code:</ins>
```
Snake - Top-most module connecting all smaller modules together wirking in conjunction with our constraints file

  clk_divider - general clock divider for the game

  button_inputs - assigns numbers to the buttons to later help with the movement case statements
      debouncer - helps eliminate unnecessary noise from button inputs

  vga_display - outputs to the VGA and helps create the snake and the features of the game including game logic
  and game modes as well as the display seen by the user
      snake_clock - snake's clock that can change with the palatte switch 
      apple_gen - logic that controls the generation of the apples in the game
      end_game - creates the conditions to lose the game 

  vga_display_2 - responsible for the Hsync and Vsync outputs of the VGA display to ensure we have an active VGA display

  topmodule - controls the 7-segment display counter for the score on the FPGA board
      refclk - creates a refresh clock for the display
      refcnt - counter for the refresh clock to simplify the display
      anodes - controls all 8 digits on the BCD display on the fpga board
      countercontrol - creates " SCOrE-XX" where XX is the score of the current game
      counter - encoder for the display
```
 
We did not need to use any test benches to test our game. Instead, we pushed and tested our code throught the FPGA and real-time inputs as we changed the corresponding outputs.  

### <ins>Project Inspiration:</ins>

- https://github.com/alaric4224/Snake

- https://www.youtube.com/watch?v=fCooCdQ-pSY
