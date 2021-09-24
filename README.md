# rubicksCubeSimulator

This sketch simulates the rubick's cube. 

SPACE KEY creates and starts a sequence that shuffles and resolves the cube
s KEY creates and starts a sequence that shuffles the cube and shows it
S KEY creates and applys a sequence that shuffles the cube instantaneously
q KEY resets the cube to the solved state

The keys written on the faces move that particular face by 90 degrees: lower case clockwise and upper case anticlockwise

The cube is made of 27 cubies, each cubie has a 3D vector that shows the direction of the upper face (yellow) and the direction of the right face (orange)
in order to show the correct orientation and a set of coordinates in order to show it in the right position. When a face is rotated a transformation matrix
is applied to the cubies of the face (both to their vectors and their coordinates)

There are some extra classes like Unit and Population that are useless. I created them to try solving the cube from a particular state using
a genetic algorithm but I found out that it was impossible since in order to solve a rubick's cube you have to go through sequences of moves
that shuffle the cube before getting to the required result.

Known issues:
The program crashes when trying to change the dimension of the cube even if it is parametrized
