# strel

```julia
    sel = strel(nhood::Matrix{<:Integer})::Sel

or

	sel = strel(name::String, par1::Int, par2::Int=0)::Sel
```

*keywords: GMT, Julia, image morphology, structuring element*

Create a strel (structuring element) object for morphological operations.
A flat structuring element is a binary valued neighborhood in which the 1's pixels are included in
the morphological computation, and the 0's pixels are not.

### Args
- `nhood`: must be a matrix of 0’s and 1’s.

- `name`: Alternatively, you can specify a structuring element name among:
  `"cross"`, `"disk"`, `"diamond"`, `"square"`, `"box"`, and `"rec"` or `"rectangle"`.

- `par1`: Is the radius of the structuring element for `"disk"` and `"diamond"` and the width
  for the remaining ones.

- `par2`: If provided (the height), all structuring elements become rectangular with a `par1 x par2`
  (width x height) size.

### Returns
A ``Sel`` type object.

See Also
--------

\myreflink{imdilate}, \myreflink{imerode}, \myreflink{imclose}, \myreflink{imopen}
