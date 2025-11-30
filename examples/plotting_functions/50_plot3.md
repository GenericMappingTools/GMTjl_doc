# Plot3d

### Examples

### Flight path

Draw a flight path approaching landing with variable line thickness and color depending on airplain height.

\begin{examplefig}{}
```julia
using GMT
D = gmtread(TESTSDIR * "assets/track_sample_data.txt", incols="7,6,3");
plot3d(D, lc=:gradient, lt=[1,5], par=(PS_LINE_CAP="round",), show=true)
```
\end{examplefig}
