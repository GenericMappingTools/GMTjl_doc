# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
xy = gmt("gmtmath -T0/180/1 T SIND 4.5 ADD");
lines(xy, axes=:af, pen=(1,:red), decorated=(dist=(2.5,0.25), marker=:star,
      ms=1, pen=(0.5,:green), fill=:blue, dec2=true), aspect="4:2", show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_15123412186067767787.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide