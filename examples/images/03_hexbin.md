# Hexagonal binning

{{doc gmtbinstats}}

## Binhex

To do hexagonal binning of a random data and counting the number of points inside each hexagon, try:

\begin{examplefig}{}
```julia
using GMT
xy = rand(100,2) .* [5 3];
D = binstats(xy, region=(0,5,0,3), inc=1, tiling=:hex, stats=:number);
imshow(D, hexbin=true, ml=0.5, colorbar=true)
```
\end{examplefig}