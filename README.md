# Hypnos Game of Life Swift

This Summer durning my Lambda School experience we had a build week who’s assignment was to build Game of Life as an iOS app.

This assignment differs in some fundamental ways. 

- Command line tool instead of a GUI
- 64-bit signed integer space: The iOS app kept the entire grid in memory. The smaller grid size made this possible. 

While I started with the basic game logic from iOS; it had to be heavily adapted since I switched from a fixed grid to a sparse grid stored in a dictionary. This results in a much smaller memory footprint; especially with smaller game files.

1. My approach was to load the file
1. Process each of the live cells and not if the cell is dying this round. 
1. In the process of checking the live cells, create the adjoining cells.
1. Then check the newly created adjoining cells whether they should be alive after this round. 
1. Remove the dead cells.
1. Add the new cells.
1. Repeat

