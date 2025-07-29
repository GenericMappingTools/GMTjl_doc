# Stereonets

The `stereonet` function plots a stereonet map in either Schmidt or Wulff projection.
It is useful for visualizing orientations of geological features such as faults and folds.

\begin{examplefig}{}
```julia
using GMT
resetGMT()		# hide
stereonet([90 30; 180 45; 270 60; 0 15; 30 45; 120 48; 225 27; 350 80])
```
\end{examplefig}
