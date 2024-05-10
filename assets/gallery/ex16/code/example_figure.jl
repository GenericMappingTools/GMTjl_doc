# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
GMT.resetGMT() # hide

gmtbegin()
	subplot(grid=(2,2), panel_size=(8,0), region=(-0.2,6.6,-0.2,6.6), figscale=1, axes=:wesn, row_axes=(left=true, row_title=true), col_axes=:bottom, margins=0.1, title="Gridding of Data")

		T = gmtread("@Table_5_11.txt")
		gmtset(FONT_ANNOT_PRIMARY="9p", FONT_TITLE="18p,Times-Roman")
		Graws0 = surface(T, inc=0.2, V=:q)
		contour(T, color="@ex_16.cpt", fill=true, title="contour (triangulate)")

		grdview(Graws0, color="@ex_16.cpt", Q=:s, title="surface (tension = 0)", panel=(1,2))

		Graws5 = surface(T, region=:same, I=0.2, tension=0.5, V=:q)
		grdview(Graws5, color="@ex_16.cpt", Q=:s, title="surface (tension = 0.5)", panel=(2,1))

		Grawt = triangulate(T, region=:same, inc=0.2, V=:q)
		Gfiltered = grdfilter(Grawt, distflag=0, F="c1")
		grdview(Gfiltered, color="@ex_16.cpt", Q=:s, title="triangulate @~\256@~ grdfilter", panel=(2,2))

	subplot()
	colorbar(pos="JBC", color="@ex_16.cpt")
gmtend(:show)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_14538614471935313907.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide