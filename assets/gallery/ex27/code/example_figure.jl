# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
resetGMT() # hide

# Gravity in tasman_grav.nc is in 0.1 mGal increments and the grid
# is already in projected Mercator x/y units.

# Make a suitable cpt file for mGal
grav_cpt = makecpt(range=(-120,120))

# Since this is a Mercator grid we use a linear projection
grdimage("@tasman_grav.nc=ns+s0.1", frame=:none, shade=:default, figscale=0.635)

# Then use gmt pscoast to plot land; get original -R from grid remark
# and use Mercator gmt projection with same scale as above on a spherical Earth
R = grdinfo("@tasman_grav.nc", nearest=:i)
R = R.text[1][3:end]
coast!(region=R, proj=:merc, figscale=0.635, frame=(axes=:WSne, annot=10, ticks=5),
       land=:black, river_fill=:white, res=:high,
       par=(FORMAT_GEO_MAP="dddF", PROJ_ELLIPSOID=:Sphere))

# Put a color legend in top-left corner of the land mask
colorbar!(region=R, pos=(inside=true, anchor=:TL, offset=1, length=(5, 0.4)),
          xaxis=(annot=50, ticks=10), ylabel="mGal", shade=true, box=(pen=1, fill=:white), show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_10765948773824140670.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide