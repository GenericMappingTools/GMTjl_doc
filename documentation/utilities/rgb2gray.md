# rgb2gray

```julia
    Igray = rgb2gray(I::GMTimage{UInt8, 3}) -> GMTimage{UInt8, 2}
```

Convert an RGB image to a grayscale image applying the television YMQ transformation.

### Args
- `I::GMTimage{UInt8, 3}`: input image of type UInt8.

### Returns
A new ``GMTimage{UInt8, 2}``.


Example
-------

\begin{examplefig}{}
```julia
using GMT

I = gmtread(GMT.TESTSDIR * "assets/bunny_cenora.jpg");
Igray = rgb2gray(I)

# Show the two side-by-side
grdimage(I, figsize=6)
grdimage!(Igray, figsize=6, xshift=6.1, show=true)
```
\end{examplefig}
