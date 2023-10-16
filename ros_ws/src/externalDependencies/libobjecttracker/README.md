# libojecttracker
This library helps to track (i.e. estimate the pose) of rigid-body objects.
It assumes that an initial estimate for the pose of each object is given.
The new poses are estimated using the iterative closest point algorithm (ICP) frame-by-frame.

The library is used in the Crazyswarm project.
