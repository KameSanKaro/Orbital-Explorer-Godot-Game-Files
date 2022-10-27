from godot import exposed, export
from godot import *

vp = "Users/KameChikara/Desktop/BinaryStarSimulation/addons/vpython"

from "Users/KameChikara/Desktop/BinaryStarSimulation/addons/vpython" import *


@exposed
class System(Spatial):

	# member variables here, example:
	a = export(int)
	b = export(str, default='foo')

	def _ready(self):
		"""
		Called every time the node is added to the scene.
		Initialization here.
		"""
		pass
		
R1=6.371e6
M1=5.972e24

G=6.67e-11

R2=1.7371e6
M2=7.348e24*(1/2)

R12=384400e3
scale=6

clst1 = sphere(pos=vector(0,0,0),radius=scale*R1, color=color.yellow, make_trail=True)
clst1.rotate(axis=vector(1,0,0), angle=pi/2)

clst2 = sphere(pos=clst1.pos+R12*vector(1,0,0),radius=3*scale*R2, color=color.white, make_trail=True)

v0 = sqrt(G*M1/R12)
clst2.p = M2*vector(0,v0,0)
clst1.p = -clst2.p

shuttle = sphere(pos=clst1.pos+R12*vector(0.5,-0.25,0), radius=scale*R2/2, color=color.cyan, make_trail=True)
shuttle.m = 1e4
vo0 = 6.2e1*1.005
theta = -10*pi/180
shuttle.p = shuttle.m*vo0*vector(0,1,0)

t = 0
dt = 1000
score = 0
r1flag = False
r2flag = False
doubleflag = False

while t<1e6:
  rate(500)
  r12 = clst2.pos- clst1.pos
  r1s = shuttle.pos - clst1.pos
  r2s = shuttle.pos - clst2.pos
  
  F12 = -G*M2*M1*norm(r12)/mag(r12)**2
  F1s = -G*M1*shuttle.m*norm(r1s)/mag(r1s)**2
  F2s = -G*M2*shuttle.m*norm(r2s)/mag(r2s)**2
  
  clst2.p = clst2.p + F12*dt
  clst1.p = clst1.p -F12*dt
  shuttle.p = shuttle.p + (F1s + F2s)*dt
  
  clst2.pos = clst2.pos + clst2.p*dt/M2
  clst1.pos = clst1.pos + clst1.p*dt/M1
  shuttle.pos = shuttle.pos + shuttle.p*dt/shuttle.m
  
  t = t + dt
  
  if t%10000 == 0:
	  if mag(r1s) > mag(r2s):
		  r2flag = True
		  score += mag(r1s)
	  if mag(r2s) > mag(r1s):
		  r1flag = True
		  score += mag(r2s)
  if r1flag == True:
	  if r2flag == True:
		  doubleflag = True
		  
if doubleflag == True:
	score = score*2

score = round(score)
scorestr = str(score)
score = scorestr[0:-7]

print("Score:", score, "points")
