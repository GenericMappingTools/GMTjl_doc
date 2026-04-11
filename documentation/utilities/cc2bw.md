# cc2bw

**Convert connected components to binary image**

---

## Description

```julia
BW = cc2bw(CC)
```

Converts a connected components structure `CC` returned by \myreflink{bwconncomp} into a binary image `BW`.

```julia
BW = cc2bw(CC, obj2keep=indices)
```

Creates a binary image containing only the connected components specified by `indices`.

---

## Input Arguments

### `CC` — Connected components (objects)

Connected components, specified as a structure with the following fields:

| Field | Description |
|-------|-------------|
| `connectivity` | Connectivity of the connected components |
| `image_size` | Size of the binary image |
| `num_objects` | Number of connected components in the binary image |
| `range` | Range of the image coordinates |
| `inc` | Image's increment (!= 1 whem image is referenced) |
| `registration` | Registration of the image |
| `x` | X coordinates of the image |
| `y` | Y coordinates of the image |
| `layout` | Memory layout of the image |
| `proj4` | Projection definition (optional) |
| `wkt` | Well-known text definition (optional) |
| `epsg` | EPSG code of the image |
| `bbox` | The bounding boxes as a vector of GMTdataset |
| `pixel_list` | Vector where each element contains the linear indices of the pixels in each object |
| `centroid` | A Float64 Matrix with the x,y coordinates of the centroids for each component |
| `area` | A vector of Float64 with the areas of each component |

### `obj2keep` — Objects to keep

Objects to keep, specified as one of these values:

- **Positive integer or vector of positive integers** — Keep the object or objects whose index
  is included in `obj2keep`. The length of `obj2keep` is less than or equal to `CC.num_objects`.

- **Logical vector** — Keep the objects whose corresponding element in `obj2keep` is `true`.
  The length of `obj2keep` must be equal to `CC.num_objects`.

---

## Output Arguments

### `BW` — Binary image

A new \myreflink{GMTimage}, returned as a logical array of the same size as `CC.image_size`.

---

## Examples


### Keep Largest Connected Components

Read a binary image and detect the connected components:

```julia
BW = gmtread(TESTSDIR * "assets/text.png");
CC = bwconncomp(BW);
```

Create a binary image that contains only the 2nd through 10th largest connected components:

\begin{examplefig}{}
```julia
using GMT
I = gmtread(TESTSDIR * "assets/text.png");	# Hide
CC = bwconncomp(I);	# Hide

# Sort by area in descending order
idx = sortperm(CC.area, rev=true);
Ifilt = cc2bw(CC, obj2keep=idx[2:10])
grdimage(I, figsize=6)
grdimage!(Ifilt, figsize=6, xshift=6.2, show=true)
```
\end{examplefig}

### Select Connected Components Based on Multiple Criteria

Read a grayscale image of grains of rice, then convert the image to binary:

```julia
I = gmtread(TESTSDIR * "assets/rice.png");
BW = binarize(I);
imshow(BW)
```

Select regions for whom these conditions apply:
- The area is greater than 50 pixels
- The bounding box is less than 15 pixels wide and is greater than or equal to 20 pixels tall

This example uses the `filter` function to get the indices of the connected components that satisfy
these criteria. The `ind2bool` function is used to convert the vector of indices returned by `filter` into
into a vector of Boolean that can be combined with the _area_ andition and te result passed to `cc2bw`.

This example also shows a problem with the \myreflink{bwconncomp} function when the BoundingBoxes
of components overlap. In such cases it may happen that parts of one component are included in the
another component. This can lead to wrong results in some areas (as can be seen with the help of
the red rectangles drawn around each component).

\begin{examplefig}{}
```julia
using GMT	# Hide
I = gmtread(TESTSDIR * "assets/rice.png");	# Hide
BW = binarize(I);	# Hide
CC = bwconncomp(BW);
selection = (CC.area .> 50) .&& ind2bool(filter(CC.bbox, true, _aspect=15/20), CC.num_objects);
BW2 = cc2bw(CC, obj2keep=selection)

# Display the original and filtered images
grdimage(BW, figsize=6, plot=(data=CC.bbox, lc=:red))
grdimage!(BW2, figsize=6, xshift=6.2, show=true)
```
\end{examplefig}


---

## See Also

\myreflink{bwconncomp}, \myreflink{binarize}