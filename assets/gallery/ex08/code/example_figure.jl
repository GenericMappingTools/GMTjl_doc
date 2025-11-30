# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
GMT.resetGMT() # hide

C = makecpt(color=:cubhelix, T=(-5000,0))
bar3(gmtread("@earth_relief_05m_g", region=(0,5,0,5)), region=(0,5,0,5,-5000,0), base=-5000,
     frame=(annot=1, axes=:WSneZ, title=:ETOPO5, cube=true),
     zaxis=(annot=1000, label="Topography (m)"), color=C,
     lw=:thinnest, proj=:Mercator, figsize=12, zsize=13, view=(200,30))
text!(mat2ds([0.1 4.7], "This is the surface of cube"), JZ=true, Z=0,
      font=(24,"Helvetica-Bold"), justify=:TL, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_17063809340940404125.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide