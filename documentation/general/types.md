# The GMT.jl types (important)

## Grid type

The GMTgrid type is how grids, (geo)referenced or not, comunicate in/out with the GMT library.
They implement the AbstractArray interface.

```julia
struct GMTgrid{T<:Real,N} <: AbstractArray{T,N}      # The type holding a local header and data of a GMT grid
    proj4::String                      # Projection string in PROJ4 syntax (Optional)
    wkt::String                        # Projection string in WKT syntax (Optional)
    epsg::Int                          # EPSG code
    geog::Int                          # Is geographic coords? 0 -> No; 1 -> [-180 180]; 2 -> [0 360]
    range::Array{Float64,1}            # 1x6[8] vector with [x_min, x_max, y_min, y_max, z_min, z_max [, v_min, v_max]]
    inc::Array{Float64,1}              # 1x2[3] vector with [x_inc, y_inc [,v_inc]]
    registration::Int                  # Registration type: 0 -> Grid registration; 1 -> Pixel registration
    nodata::Union{Float64, Float32}    # The value of nodata
    title::String                      # Title (Optional)
    comment::String                    # Remark (Optional)
    command::String                    # Command used to create the grid (Optional)
    cpt::String                        # Name of a recommended GMT CPT name for this grid.
    names::Vector{String}              # To use whith multi-layered and when layers have names (Optional)
    x::Array{Float64,1}                # [1 x n_columns] vector with XX coordinates
    y::Array{Float64,1}                # [1 x n_rows]    vector with YY coordinates
    v::Union{Vector{<:Real}, Vector{String}}    # [v x n_bands]   vector with VV (vertical for 3D grids) coordinates
    z::Array{T,N}                      # [n_rows x n_columns] grid array
    x_unit::String                     # Units of XX axis (Optional)
    y_unit::String                     # Units of YY axis (Optional)
    v_unit::String                     # Units of Vertical axis (Optional)
    z_unit::String                     # Units of z vlues (Optional)
    layout::String                     # A three character string describing the grid memory layout
    scale::Union{Float64, Float32}=1f0 # When saving in file apply `z = z * scale + offset`
    offset::Union{Float64, Float32}=0f0
    pad::Int=0                         # When != 0 means that the array is placed in a padded array of PAD rows/cols
    hasnans::Int=0                     # 0 -> "don't know"; 1 -> confirmed, "have no NaNs"; 0 -> confirmed, "have NaNs"
end
```

## Image type

```julia
struct GMTimage{T<:Unsigned, N} <: AbstractArray{T,N}   # The type holding a local header and data of a GMT image
    proj4::String              # Projection string in PROJ4 syntax (Optional)
    wkt::String                # Projection string in WKT syntax (Optional)
    epsg::Int                  # EPSG code
    geog::Int                  # Is geographic coords? 0 -> No; 1 -> [-180 180]; 2 -> [0 360]
    range::Vector{Float64}     # 1x6 vector with [x_min x_max y_min y_max z_min z_max]
    inc::Vector{Float64}       # 1x2 vector with [x_inc y_inc]
    registration::Int          # Registration type: 0 -> Grid registration; 1 -> Pixel registration
    nodata::Unsigned           # The value of nodata
    color_interp::String       # If equal to "Gray" an indexed image with no cmap will get a gray cmap
    metadata::Vector{String}   # To store any metadata that can eventually be passed to GDAL (Optional)
    names::Vector{String}      # To use whith multi-band and when bands have names (Optional)
    x::Vector{Float64}         # [1 x n_columns] vector with XX coordinates
    y::Vector{Float64}         # [1 x n_rows]    vector with YY coordinates
    v::Vector{Float64}         # [v x n_bands]   vector with vertical coords or wavelengths in hypercubes (Optional)
    image::Array{T,N}          # [n_rows x n_columns x n_bands] image array
	labels::Vector{String}     # Labels of a Categorical CPT
	n_colors::Int              # Number of colors stored in the vector 'colormap'
    colormap::Vector{Int32}    # A vector with n_colors-by-4 saved column-wise
    alpha::Matrix{UInt8}       # A [n_rows x n_columns] alpha array
    layout::String             # A four character string describing the image memory layout
    pad::Int                   # When != 0 means that the array is placed in a padded array of PAD rows/cols
end
```

## Dataset type

```julia
struct GMTdataset{T<:Real, N} <: AbstractArray{T,N}
    data::Array{T,N}           # Mx2 Matrix with segment data
    ds_bbox::Vector{Float64}   # Global BoundingBox (for when there are many segments)
    bbox::Vector{Float64}      # Segment BoundingBox
    attrib::Dict{String, String} # Dictionary with attributes/values (optional)
    colnames::Vector{String}   # Column names. Antecipate using this with a future Tables inerface
    text::Vector{String}       # Array with text after data coordinates (mandatory only when plotting Text)
    header::String             # String with segment header (Optional but sometimes very useful)
    comment::Vector{String}    # Array with any dataset comments [empty after first segment]
    proj4::String              # Projection string in PROJ4 syntax (Optional)
    wkt::String                # Projection string in WKT syntax (Optional)
    epsg::Int                  # EPSG projection code (Optional)
    geom::Integer              # Geometry type. One of the GDAL's enum (wkbPoint, wkbPolygon, etc...)
end
```

## CPT type

```julia
struct GMTcpt
    colormap::Array{Float64,2} # Mx3 matrix equal to the first three columns of cpt
    alpha::Array{Float64,1}    # Vector of alpha values. One for each color.
    range::Array{Float64,2}    # Mx2 matrix with z range for each slice
    minmax::Array{Float64,1}   # Two elements Vector with zmin,zmax
    bfn::Array{Float64,2}      # A 3x3(4?) matrix with BFN colors (one per row) in [0 1] interval
    depth::Cint                # Color depth: 24, 8, 1
    hinge::Cdouble             # Z-value at discontinuous color break, or NaN
    cpt::Array{Float64,2}      # Mx6 matrix with r1 g1 b1 r2 g2 b2 for z1 z2 of each slice
	categorical::Int           # Is this CPT categorical? 0 = No, 1 = Yes, 2 = Yes and keys are strings.
    label::Vector{String}      # Labels of a Categorical CPT
    key::Vector{String}        # Keys of a Categorical CPT
    model::String              # String with color model rgb, hsv, or cmyk [rgb]
    comment::Vector{String}    # Cell array with any comments
end
```

## Postscript type

```julia
struct GMTps
    postscript::String         # Actual PS plot (text string)
    length::Int                # Byte length of postscript
    mode::Int                  # 1 = Has header, 2 = Has trailer, 3 = Has both
    comment::Vector{String}    # Cell array with any comments
end
```

## Face-Vertices type

```julia
struct GMTfv{T<:AbstractFloat} <: AbstractMatrix{T}
	verts::AbstractMatrix{T}    # Mx3 Matrix with the data vertices
	faces::Vector{<:AbstractMatrix{<:Integer}}  # A vector of matrices with the faces. Each row is a face
	faces_view::Vector{Matrix{Int}}             # A subset of `faces` with only the visible faces from a certain perspective
	bbox::Vector{Float64}       # The vertices BoundingBox
	zscale::Float64             # A multiplicative factor to scale the z values
	bfculling::Bool             # If culling of invisible faces is wished
	proj4::String               # Projection string in PROJ4 syntax (Optional)
	wkt::String                 # Projection string in WKT syntax (Optional)
	epsg::Int                   # EPSG projection code (Optional)
end
```
