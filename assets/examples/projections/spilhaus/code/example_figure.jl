# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
resetGMT()		# hide
grdimage("@earth_relief_15m", shade=true, R=:d, proj="+proj=spilhaus",
          coast=(shore=true, frame="Wbet 30g"), show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_386016505775832623.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide