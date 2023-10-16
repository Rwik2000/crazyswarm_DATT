"""Takeoff-hover-land for one CF. Useful to validate hardware config."""

from pycrazyswarm import Crazyswarm
import numpy as np


TAKEOFF_DURATION = 1.5
HOVER_DURATION = 1
TURN_DURATION = 3
MOVE_DURATION = 2
CIRCLE_DURATION = 10
CIRCLE_RADIUS = 1

def circle_ref(t, origin, radius=1, duration=5):
    c = 2*np.pi / duration
    return np.array([radius*np.cos(t * c), radius*np.sin(t * c), 0]) + origin

def main():
    swarm = Crazyswarm()
    timeHelper = swarm.timeHelper
    cf = swarm.allcfs.crazyflies[0]

    print(cf.position())
    cf.takeoff(targetHeight=0.5, duration=TAKEOFF_DURATION)
    timeHelper.sleep(TAKEOFF_DURATION)
    origin = cf.position()
    
    cf.goTo((CIRCLE_RADIUS, 0, 0), np.radians(0), relative=True, duration=MOVE_DURATION)
    timeHelper.sleep(MOVE_DURATION)
    
    times = np.linspace(0, CIRCLE_DURATION, CIRCLE_DURATION * 50)    
    for t in times:
        print(t, cf.position())
        cf.cmdPosition(circle_ref(t, origin, radius=CIRCLE_RADIUS, duration=CIRCLE_DURATION))
        timeHelper.sleep(1/50)

    cf.notifySetpointsStop()
    
    cf.goTo((-CIRCLE_RADIUS, 0, 0), np.radians(0), relative=True, duration=MOVE_DURATION)
    timeHelper.sleep(MOVE_DURATION)
    
    cf.land(targetHeight=0.04, duration=TAKEOFF_DURATION)
    timeHelper.sleep(TAKEOFF_DURATION)


if __name__ == "__main__":
    main()
