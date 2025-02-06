# bwskell

```julia
bwareaopen(I::Union{GMTimage{UInt8,2}, GMTimage{Bool,2}}; keepwhites::Bool=false, keepblacks::Bool=false, kwargs...)::GMTimage
```

*keywords: GMT, Julia, image processing, area opening*

Remove all connected components (groups of pixels) that have fewer than P pixels from the binary image ``Ibw``.

Remove groups of pixels in the image that are smaller than a provided threshold size (in pixels)
and replaces them with the pixel value of the largest neighbor polygon. This operation is known as an area opening. 

_Polygons_ are determined as regions of the image where the pixels all have the same value, and that are
contiguous (connected). The work is done by the GDAL ``GDALSieveFilter`` function.


### Args
- `I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}`: Input binary image. It can be a GMTimage object or a file name that once read by ``gmtread`` returns a binary image.

### Kwargs
- `keepwhites`: If set to `true` keeps all the white pixels (or true) in input image as white in the output image.
   That is, only let the black pixels be set to white (or true).

- `keepblacks`: If set to `true` keeps the black pixels (or false) in the input image as black in the output image.
   That is, only let the white pixels be set to black (or false).

- `threshold`: groups of pixels with sizes smaller than this will be merged into their largest neighbor.
   The default is 10. 

- `conn`: Connectivity. Either 4 indicating that diagonal pixels are not considered directly adjacent for polygon
   membership purposes or 8 indicating they are. The default is 4.

### Returns
A new binary \myreflink{GMTimage}.

Example
-------

\begin{examplefig}{}
```julia
using GMT

# Read the test image
I = gmtread(TESTSDIR * "assets/face_bw.png");

# Remove the small blobs using the default threshold size (10 pixels)
Ic = bwareaopen(I);
grdimage(I, figsize=6)
grdimage!(Ic, figsize=6, xshift=6, show=true)
```
\end{examplefig}

The result is almos good as all salt-&-pepper noise has gone, buy two outer white patches 
survived cleaning. We could have used a larger than 10 pixes threshold value in `bwareaopen` call
but that would have removed the _mouth_ as well. To solve this we are going to take a more brute
force approach. We will remove all patches smaller than 1000 pixels, which removes also the eyes,
eyebrows and mouth but restore them in the same step by invoking the option `keepblacks`. 


\begin{examplefig}{}
```julia
using GMT

I = gmtread(TESTSDIR * "assets/face_bw.png");  #Hide

# Brute cleaning
Ic1 = bwareaopen(I, thresh=1000);

# Retain the "blacks"
Ic2 = bwareaopen(Ic1, thresh=1000, keepblacks=true);

# But this still leaves some noise over the eyes, so clean it again
Ic3 = bwareaopen(Ic2)

grdimage(Ic1, figsize=5)
grdimage!(Ic2, figsize=5, xshift=5)
grdimage!(Ic3, figsize=5, xshift=5, show=true)
```
\end{examplefig}
