# gunique

```
u, ind = gunique(x::AbstractVector; sorted=false)
```

Return an array containing only the unique elements of `x` and the indices `ind` such that `u = x[ind]`. If `sorted` is true the output is sorted (default is not)
