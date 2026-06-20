# fiber-splice-box

Fiber splice box CAD assets.

## Mirrored barrel hinge

`hinge.scad` defines a simple parametric OpenSCAD hinge:

- two mirrored 20 mm x 20 mm leaves
- 6 mm leaf thickness
- 6 mm outside-diameter barrel along the joining edge
- shifted/interleaved barrel knuckles so the mirrored side aligns with the opposite side
- 2.4 mm hinge-pin bore through all barrel segments

Open the model with OpenSCAD, or render it from the command line:

```sh
openscad -o hinge.stl hinge.scad
```
