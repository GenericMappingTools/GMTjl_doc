# append2fig

```julia
append2fig(fname::String)
```

Move the file `fname` to the default name and location (GMT_user.ps in tmp). The `fname` should be
a PS file that has NOT been closed. Posterior calls to plotting methods will append to this file.
Useful when creating figures that use a common base map that may be heavy (slow) to compute.
