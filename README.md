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

## CR-6 filament spool adapter versions

`cr6/filament_spool_adapterV1.scad` defines the first parametric two-piece spool
adapter. `cr6/filament_spool_adapterV2.scad` keeps V1 intact and adds a
final through-bore cut so the shaft hole passes through the full adapter width.
The defaults adapt a 30 mm shaft to a 52 mm spool bore with a 60 mm outer
keeper/flange supported against the side of the spool.

Adjust the shaft, spool, keeper, straight spool-seat width, taper end diameter,
overall width, and clearance variables at the top of the file. Use new
versioned SCAD filenames for future adapter changes
(`filament_spool_adapterV2.scad`, `filament_spool_adapterV3.scad`, etc.) so
concurrent branches can merge without overwriting the same model file.

Render the latest V2 from the command line:

```sh
openscad -o cr6/filament_spool_adapterV2.stl cr6/filament_spool_adapterV2.scad
```
