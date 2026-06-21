# Maintenance scripts

These scripts support the STL-to-OpenSCAD workflow used for `parts/hinge_small`.
They are intended to run after the repository setup script installs OpenSCAD,
Blender, mesh tools, and Python geometry libraries.

## Common commands

```bash
# Fast checks that do not require OpenSCAD.
python3 scripts/check_hinge_small_customizer.py
python3 scripts/measure_mesh_bounds.py parts/hinge_small/*.stl

# Render/export all v6 hinge views when OpenSCAD is available.
scripts/render_hinge_small_v6.sh /tmp/hinge_small_v6_exports

# Compare generated v6 OFF dimensions against the original STL dimensions.
python3 scripts/compare_hinge_small_v6.py /tmp/hinge_small_v6_exports

# Run the maintenance workflow. Rendering is skipped if OpenSCAD is missing.
scripts/maintenance.sh
```
