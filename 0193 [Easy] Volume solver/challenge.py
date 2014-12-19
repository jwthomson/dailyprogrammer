# volume
import math

def cube_root(x):
  return math.exp(math.log(x) / 3)

def cube(vol):
  return [cube_root(vol)]

def cylinder(vol):
  r = math.sqrt(vol)
  h = vol / (math.pi * (r**2))
  return [r, h]

print(cube(27))
print(cylinder(27))