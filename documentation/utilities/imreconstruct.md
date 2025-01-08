# imreconstruct

```julia
I = imreconstruct(marker::Union{Matrix{Bool}, Matrix{UInt8}}, Imask::GMTimage{<:UInt8, 2}; conn=4, insitu=true)
```

*keywords: GMT, Julia, morphological reconstruction*

Perform morphological reconstruction of the image `marker` under the image `mask`.

The elements of `marker` must be less than or equal to the corresponding elements of `mask`.
If the values in `marker` are greater than corresponding elements in `mask`, then ``imreconstruct``
clips the values to the mask level before starting the procedure. The worphological work is
done by the Leptonica function ``pixSeedfillGray``.

### Args
- `marker`: The image to be reconstructed (will hold the reconstructed image). This can be a matrix
  or a \myreflink{GMTimage} with Boolean or UInt8 types.

- `mask`: The mask image. Types (\myreflink{GMTimage} or matrix) are Boolean or UInt8.

### Kwargs
- `conn::Int`: Connectivity for the image reconstruction (4 or 8). Default is 4.
- `insitu::Bool`: If true, the input images are treated as in situ. Default is true.

### Returns
- A new \myreflink{GMTimage} (or Matrix)

Example
-------

Use reconstruction to segment an image.

\begin{examplefig}{}
```julia
using GMT

text(["Hello World"], region=(1.92,2.08,1.97,2.02), x=2.0, y=2.0,
     font=(30, "Helvetica-Bold", :white),
     frame=(axes=:none, bg=:black), figsize=(6,0), name="tmp.png")

# Read only one band (althouh gray scale the "tmp.png" is actually RGB)
I = gmtread("tmp.png", band=1);

# Create a marker image that identifies the object in the image you want to extract through segmentation.
# For this example, identify the "W" in the word "World".
marker = fill(UInt8(0),(size(I)));
marker[390,130] = UInt8(255);

# Perform segmentation of the mask image using the marker image.
Ir = imreconstruct(Im, I)
grdimage(I, figsize=8, yshift=2.56)
grdimage!(Ir, figsize=8, show=true)
```
\end{examplefig}


See Also
--------

\myreflink{fillsinks}, \myreflink{imfill}
