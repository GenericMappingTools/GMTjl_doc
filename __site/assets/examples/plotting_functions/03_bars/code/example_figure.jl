# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

G = GMT.peaks();      # Create a 'peaks' grid
cmap = grd2cpt(G);    # Colormap with the grid's data range

bar3(G,               # 'G' is the grid created above
     lw=:thinnest,    # Line thickness (0.25 pt)
     color=cmap,      # Paint the prisms with colormap computed from grid
     show=true)       # Display the figure.
end # hide
mv(joinpath(tempdir(), "GMTjl_tmp.png"), joinpath(@OUTPUT, "example_2146444488728053260.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide