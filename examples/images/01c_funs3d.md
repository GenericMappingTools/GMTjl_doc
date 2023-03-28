## Plot surfaces

### Ackley

\myreflink{grdview} can plot 3-D surfaces with them provided as grids or as function equations
or some predefined function names. Note that the `view` option controls the azimuth and
elevation angle of the view. 

There are a couple of predefined functions that can plotted for demonstration purposes.
For example the [_ackley_](https://en.wikipedia.org/wiki/Ackley_function) function

\begin{examplefig}{}
```julia
using GMT
imshow("ackley", view=(159,30), shade=true)
```
\end{examplefig}

### Rosenbrock

Or the *rosenbrock* that looks like a manta ray (other options are *parabola, eggbox,  sombrero*)"

\begin{examplefig}{}
```julia
using GMT
imshow("rosenbrock", view=(159,30), shade=true)
```
\end{examplefig}

But besides these predefined functions one can any function that defines a surface.
For example a parabola can be plotted with the code bellow. First argument can be an
anonymous function (like the example) of a function. Second and third args contain
the plotting domain and step used to evaluate the function.

\begin{examplefig}{}
```julia
using GMT
imshow((x,y) -> sqrt(x^2 + y^2), -5:0.05:5, -5:0.05:5, view=(159,30), shade=true, frame=:autoXYZg)
```
\end{examplefig}

And we can plot 3D lines too. Same thing, give a parametric equation and

\begin{examplefig}{}
```julia
using GMT
plot3d(x -> sin(x)*cos(10x), y -> sin(y)*sin(10y), z -> cos(z), 0:pi/200:pi, lt=2, lc=:brown, frame=:autoXYZg, show=true)
```
\end{examplefig}