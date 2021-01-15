# Hypnos Game of Life Swift

This project is based on John Conway's [Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life) and utilizes [Life 1.06](https://www.conwaylife.com/wiki/Life_1.06) file format for input. It is in 64-bit signed integer space. It was built in Xcode (Version 12.3) using Swift version 5.3.2. It has been ported to [C#](https://github.com/gerrior/Hypnos-Game-of-Life-CSharp).

This Summer durning my Lambda School experience we had a "build week" in which the assignment was to build Game of Life as an iOS app.

This assignment differs in some fundamental ways. 

- Command line tool instead of a GUI
- 64-bit signed integer space: The iOS app kept the entire grid in memory. The smaller grid size made this possible. 

While I started with the basic game logic from iOS; it had to be heavily adapted since I switched from a fixed grid to a sparse grid stored in a dictionary. This results in a much smaller memory footprint; especially with smaller game files.

### My Approach
1. Load the file.
1. The game board only contains live cells.
1. Process each live cell in the game board and note if the cell is dying this iteration. 
1. In the process of checking the game board, note adjoining cells.
1. Check each of the adjoining cells to determine whether the cell should be alive (added to the game board) after this iteration. 
1. Remove the dead cells from the game board.
1. From the list of adjoining cells, add any new cells to the game board.
1. Got to step 3 and repeat number of generations specified by the user.
1. Save final game board to file with ```-result.txt``` appended to input filename.

### How to Review
Start with ```main.swift```. The bulk of the program logic is in ```GameOfLife.swift``` with a supporting object in ```Cell.swift```. ```ConsoleIO.swift``` supports the command line program (file input/output and parsing the command line) and should be reviewed last.