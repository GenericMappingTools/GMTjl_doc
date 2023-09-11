# info

```julia
info(GI, showdata::Bool=true; crs::Bool=false)
```

Shows information about the `GI` \myreflink{GMTgrid} or \myreflink{GMTimage} that includes dimensional and,
if exists, referencing data.

- `showdata`: Boolean that controls if a small array subset is printed or not.

- `crs`: Boolean that if `true` only prints the referencing information.

```julia
info(D::GDtype; crs::Bool=false, attribs=false, att="")
```

Shows information about the `D` \myreflink{GMTdataset} (or vector of them).

- `crs`: Boolean that if `true` only prints the referencing information.

- `attribs`: In case the dataset has attributes, like they do when resulting from reading a shape file, use
  this parameter to print only the attribute table. A setting of `attribs=true` will print the entire attributes
  table. Give a positive number, _e.g._ `attribs=5` to show only the first 5 attributes. A negative number prints
  the last n attribs. A vector range, `attribs=5:9` is also accepted.

- `att`: Name of one attribute. Returns a string vector with the values of the attribute passed into this option.
  Example, ``attn = info(D, att="NAME")`` returns all values of the attribute ``NAME``.

```julia
info(any)`
```

Runs ``show(stdout, "text/plain", any)`` which prints all elements of `any`. Good for printing the entire vector or matrix.
