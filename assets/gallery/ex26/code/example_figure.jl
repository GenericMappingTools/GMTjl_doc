# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
resetGMT() # hide

lat = 41.5; lon = -74;  alt = 160;  tilt = 0; azim = 0; twist = 0;  width = 0;  height = 0;
coast(region=:global360, proj=(name=:ortho, center=[lon, lat], parallels=[alt, azim, tilt, twist, width, height]), xshift=2.5, frame=(annot=5, grid=5), land=:lightbrown, water=:lightblue, shore=true, borders=((level=1,pen=(1,:red)), (level=2, pen=0.5)), figsize=10, yshift=12)

# Now point from an altitude of 160 km with a specific tilt and azimuth and with a wider restricted
# view and a boresight twist of 45 degrees
tilt=55;  azim=210; twist=45; width=30; height=30;
coast!(proj=(name=:ortho, center=[lon, lat], parallels=[alt, azim, tilt, twist, width, height]), frame=:same, 
       land=:lightbrown, water=:lightblue, shore=true, rivers=(level=:a, pen=:blue), res=:intermediate,
       borders=:a, figsize=12, xshift=2.5, yshift=-10, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_12506980843332438246.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide