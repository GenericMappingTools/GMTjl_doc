# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

Gbat = gmtread(GMT.TESTSDIT * "/assets/model_interface_4parker.grd");

# Compute the gravity due to the interface. The direct problem
Ggrv = parkergrav(Gbat, rho=400, nterms=10)

# Compute the interface from the gravity. The inverse problem.
Gbat_inv = parkergrav(Ggrv, "inv", rho=400, depth=20.0)

# Recompute the gravity from inverted topography
Ggrv_rec = parkergrav(Gbat_inv, rho=400, nterms=10)

# The residues 
Gres = Ggrv - Ggrv_rec;

# Plot the results
grdimage(Gbat, figsize=7, title="Initial topography (m)", contour=true, colorbar=true)
grdimage!(Ggrv, figsize=7, xshift=9, title="Gravity anomaly (mGal)",
          cmap=:auto, contour=true, colorbar=true)
grdimage!(Gbat_inv, figsize=7, xshift=-9, yshift=-9.0, title="Calculated Interface (m)",
          cmap=:auto, contour=true, colorbar=true)
grdimage!(Gres, figsize=7, xshift=9, title="Residues (mGal)", cmap=:auto,
          contour=true, colorbar=true, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_17254431186972183576.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide