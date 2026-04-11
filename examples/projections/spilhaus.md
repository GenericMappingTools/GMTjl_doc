# Spilhaus projection

The Spilhaus Projection presents the world seas and oceans as a single body of water.

\begin{examplefig}{}
```julia
using GMT
resetGMT()		# hide
grdimage("@earth_relief_15m", shade=true, R=:d, proj="+proj=spilhaus",
          coast=(shore=true, frame="Wbet 30g"), show=true)
```
\end{examplefig}
