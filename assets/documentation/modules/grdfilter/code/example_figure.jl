# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

# Original data
grid = gmtread("@earth_relief_05m", region=(150,200,10,40))

# Apply different filters
G_median = grdfilter(grid, F="m600", D=4, I=0.5)
G_gauss = grdfilter(grid, F="g600", D=4, I=0.5)
G_boxcar = grdfilter(grid, F="b600", D=4, I=0.5)
G_mode = grdfilter(grid, F="p600", D=4, I=0.5)

# Visualize differences
subplot(grid=(2,2), F=(width=20, height=15))
    grdimage(G_median, panel=(1,1), title="Median")
    grdimage(G_gauss, panel=(1,2), title="Gaussian")
    grdimage(G_boxcar, panel=(2,1), title="Boxcar")
    grdimage(G_mode, panel=(2,2), title="Mode")
subplot(:show)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_298362071837497979.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide