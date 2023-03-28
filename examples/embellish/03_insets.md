# Map insets

### Inset of a Japan area

`insets` adds an inset figure inside a larger figure. Because the `inset` is a GMT so called 
*modern mode* feature in this example we will use the ``gmtbegin() ... gmtend()`` form.

<!-- -->
\begin{examplefig}{}
```julia
using GMT

gmtbegin()
    coast(region=[137.5, 141, 34, 37], proj="UTM54", frame=(axes=:WSen, annot=:auto, ticks=:auto),
          land=:lightbrown, water=:azure1, shorelines=1, area=1000)
    # Create an inset map, setting it at bottom right with a x- and y-offsets of 0.1 cm.
    inset(inset_box=(anchor=:BR, width=3, offset=0.1), box=(fill=:white, pen=1))
        coast(region=[129, 146, 30, 46], proj="UTM54", figsize=3,
              DCW=(country=:JP, fill=:lightbrown, pen=0.2), area=10000)
        plot([137.5 34 141 37], marker="r+s", ml=(1, :blue))    # A blue rectangle
    inset(:end)
gmtend(:show)
```
\end{examplefig}
