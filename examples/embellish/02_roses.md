## Magnetic compass

Draw a magnetic compass

<!-- -->
\begin{examplefig}{}
```julia
using GMT

basemap(region=(-8,8,-6,6), proj=:Mercator,
        compass=(map="", anchor=(0,0), width=6, dec=-14.5, annot=(45,10,5,30,10,2),
                 rose_primary=(0.25,:blue), rose_secondary=0.5, labels="", justify=:CM),
        par=(FONT_ANNOT_PRIMARY=9, FONT_LABEL=14, FONT_TITLE=24, MAP_TITLE_OFFSET="7p",
             MAP_VECTOR_SHAPE=0.5, MAP_TICK_PEN_SECONDARY="thinner,red",
             MAP_TICK_PEN_PRIMARY="thinner,blue"),
        show=true)
```
\end{examplefig}

## Plain and fancy directional map roses. 

\begin{examplefig}{}
```julia
using GMT

# Bare-bones plain rose showing arrow towards north and a cross indicating the cardinal directions 
basemap(region=(-5,5,-5,5), proj=:merc, figscale=0.4, frame=:none,
        rose=(map=true, anchor=(0,0), justify=:CM, width=2.5))

# Fancy rose width a north label
basemap!(rose=(map=true, anchor=(0,0), justify=:CM, width=2.5, fancy=true, labels=",,,N"), xshift=3)

# Fancy directional rose at level 3 with labels
basemap!(rose=(map=true, anchor=(0,0), justify=:CM, width=2.5, fancy=3, labels=true),
         region=(-7,7,-5,5), xshift=3.5, show=true)
```
\end{examplefig}