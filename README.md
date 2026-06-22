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

## CR-6 filament spool adapter

`cr6/filament_spool_adapter.scad` defines a parametric two-piece spool
adapter. The defaults adapt a 30 mm shaft to a 52 mm spool bore with a 60 mm
outer keeper/flange supported against the side of the spool.

Adjust the shaft, spool, keeper, width, and clearance variables at the top of
the file, then render it from the command line:

```sh
openscad -o cr6/filament_spool_adapter.stl cr6/filament_spool_adapter.scad
```
