# Pcolor

{{doc pcolor}}

## Rectangular grid

Create a pseudocolor plot with a rectangular grid.

\begin{examplefig}{}
```julia
using GMT
G = GMT.peaks(N=21);
pcolor(G, outline=(0.5,:dot), show=true)
```
\end{examplefig}


## Rectangular grid with labels

\begin{examplefig}{}
```julia
using GMT
G = GMT.peaks(N=21);
pcolor(G.x, G.y, G.z, labels=:yes, show=true)
```
\end{examplefig}


## Non-rectangular grid

Create a pseudocolor plot with a non-rectangular grid.

\begin{examplefig}{}
```julia
using GMT
X,Y = GMT.meshgrid(-3:6/17:3);
XX = 2*X .* Y;
YY = X.^2 .- Y.^2;
pcolor(XX,YY, reshape(repeat([1:18; 18:-1:1], 9,1), size(XX)), lc=:black, show=true)
```
\end{examplefig}