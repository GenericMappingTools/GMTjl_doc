# gravmag3d

```julia
gravmag3d(fname::String="", arg1=nothing, kwargs...)
```

*keywords: GMT, Julia, gravity, magnetism*

Description
-----------

Compute the gravity or magnetic anomaly of a body described by a set of triangles.
The output can either be along a given set of xy locations or on a grid. This method is not particularly
fast but allows computing the anomaly of arbitrarily complex shapes.

Required Arguments (not all)
----------------------------

- **fname** : Optional positional argument with the name of a _xyz..._ file that can be read by \myreflink{gmtread}.
    The *xyz* file can have 3, 4, 5, 6 or 8 columns. In first case (3 columns) the magnetization (or density)
    are assumed constant (controlled by **density** or **mag_params**). Following cases are: 4 columns -> 4rth col
    magnetization intensity; 5 columns: mag, mag dip; 6 columns: mag, mag dec, mag dip; 8 columns: field dec, field dip,
    mag, mag dec, mag dip.  When n columns > 3 the third argument of the **mag_params** option is ignored.
