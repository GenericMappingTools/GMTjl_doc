# imbothat

```julia
J = imbothat(I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}; hsize=3, vsize=3)::GMTimage
```

Do a morphological bop-hat operation on a grayscale or binary image.

Bottom-hat computes the morphological closing of the image and does a: `closing - orig_image`
This transform isolates pixels that are darker than other pixels in their neighborhood.

### Args
- `I::Union{GMTimage{<:UInt8, 2}, GMTimage{<:Bool, 2}}`: Input image.

### Kwargs
- `hsize::Int=3`: Horizontal size of the 'box' structuring element.

- `vsize::Int=3`: Vertical size of the 'box' structuring element.

### Returns
A new \myreflink{GMTimage} of the same type as `I` with the bothat applied.


See Also
--------

\myreflink{imdilate}, \myreflink{imerode}, \myreflink{imopen}, \myreflink{imtophat}
