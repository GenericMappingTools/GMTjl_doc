# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT, Rasters		# Hide
import NCDatasets		# Hide
url = "https://archive.unidata.ucar.edu/software/netcdf/examples/tos_O1_2001-2002.nc";	# Hide
filename = download(url, "tos_O1_2001-2002.nc");	# Hide
A = Raster(filename);	# Hide

G = mat2grid(A[Ti=1:6], offset=-273.15);
viz(G, proj=:Robinson, coast=true, colorbar=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_14493649158334234364.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide