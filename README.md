# Spaced

Spaced is a [Turing-Tarpit](https://en.wikipedia.org/wiki/Turing_tarpit) created for the [December 2012 PLT games](http://www.pltgames.com/competition/2012/12). It aims to simulate a universal Turing Machine, and therefore is Turing complete.

Spaced uses whitespace to move from cell to cell - this makes for a visual indiction of the movement over the instruction sets. Spaced also allows you to use traditional operators where preservation of the cell pointer across lines is required.

## Usage

To run, this example implementation of Spaced requires Ruby (tested on 1.9.3). Run programs as follows:

    ruby spaced.rb <path to program>

Spaced programs can accept input from STDIN, which can either be piped in or typed on the terminal:

    echo 'Hello World' | ruby spaced.rb examples/reverse_input
    ruby spaced.rb examples/reverse_input # Type your entry, then press Ctrl+D to indicate the EOF.

## Syntax

Spaced uses the idea of cells to store data as a program is run. Each cell can contain one byte worth of information. Spaced does not limit the number of cells you can use to a specific number, nor does it preset any cells to a certain value. If a cell is not set, you can consider its value `null`, which when printed will output nothing.

Spaced makes use of the operators described in the below table to make up programs. All the operators can be followed by a number, which will make the executor repeat that command that many times (eg. +10 will increment the current cell ten times), although not all operators will make sense to suffix with a number.

| Symbol | Description |
|--------|-------------|
| >      | Move the cell pointer one cell to the right. |
| <      | Move the cell pointer one cell to the left. |
| @      | Toggle whitespace mode on and off. When on (the default), each space at the start of a line moves the cell pointer to the right and the cell pointer is reset to zero on each line. When off, whitespace is ignored and the cell pointer position is preserved across lines. |
| +      | Increment the value of the current cell. |
| -      | Decrement the value of the current cell. |
| "      | Print the value of the current cell as an ASCII character. |
| !      | Print the value of the current cell as an integer. |
| *      | Indicate the start of a loop. |
| ^      | Moves back to the previous loop start if the current cell is not 0, effectively creating a loop. |
| &      | Reads one byte worth of input and stores at the current cell as the ASCII code integer value. |

Any characters other that the ones mentioned above will be ignored. Thus comments can be inserted anywhere in the source code of a spaced program so long as they don't contain any of the reserved characters above.

## Examples

### Hello World

```
+10 # Set cell 0 to 10.
* # Start a loop.
 +7 # Add 7 to cell 1.
  +7 # Add 7 to cell 2.
   +8 # Add 8 to cell 3.
    +8 # Add 8 to cell 4.
     +8 # Add 8 to cell 5.
      +3 # Add 3 to cell 6.
       +9 # Add 9 to cell 7.
        +8 # Add 8 to cell 8.
         +8 # Add 8 to cell 9.
          +8 # Add 8 to cell 10.
           +7 # Add 7 to cell 11.
- # Decrement cell 0 by 1.
^ # Start loop again if cell 0 is greater than 0.

# The cells should look like this at this point:
# 70 70 80 80 80 30 90 80 80 80 70

 +2 # Add 2 to cell 1 and print it: H
 "
  - # Minus 1 from cell 2 and print it: E
  "
   -4 # Minus 4 from cell 3 and print it: L
   "
    -4 # Minus 4 from cell 4 and print it: L
    "
     - # Minus 1 from cell 5 and print it: O
     "
      +2 # Add 2 to cell 6 and print it: <space>
      "
       -3 # Minus 3 from cell 7 and print it: W
       "
        - # Minus 1 from cell 8 and print it: O
        "
         +2 # Add 2 to cell 9 and print it: R
         "
          -4 # Minus 4 from cell 10 and print it: L
          "
           -2 # Minus 2 from cell 11 and print it: D
           "
```

### Reverse Input

```
@ # Turn off whitespace mode.
* # Start a loop.
>& # Move the cell pointer right and fill it with a character.
^ # Continue this until we reach the end of the data, eg. EOF, which is 0 (null).
< # Move left so we don't print the EOF we stored.
* # Start a loop.
"< # Print the char at the current cell and move right.
^ # Continue until we reach cell 0, which is set to 0.
```
