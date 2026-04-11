# ODE2ds

```
D = ODE2ds(sol; interp=0)
```

Extract data from a DifferentialEquations solution type and return it into a GMTdataset.

- `interp`: == 0 means we return the original points (no interpolation). == 2 => do data interpolation to
  the double of original number of points. == 3 => three times, == n => n times.
