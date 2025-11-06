# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

Cgeoid = grd2cpt("@india_geoid.nc");
Cgray  = makecpt(cmap=150, range="-10000,10000", nobg=true);
sealand(grdimage, "@india_geoid.nc", (region="@india_geoid.nc", shade="+d", proj=:Merc,
                                      cmap=Cgeoid, title="Clipping of Images"),
        grdimage, "@india_topo.nc", (shade="+d", cmap=Cgray), shore=0.5)
colorbar!(pos=(inside=true, anchor=:TR, offset=(0.8,0.2), size=(10,0.5), horizontal=true),
          cmap=Cgeoid, xaxis=(annot=5, ticks=1), ylabel=:m, shade=true, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_9238987908760033631.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide