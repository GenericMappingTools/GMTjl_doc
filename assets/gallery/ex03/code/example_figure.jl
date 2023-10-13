# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
GMT.resetGMT() # hide

# First, we use "fitcircle" to find the parameters of a great circle
# most closely fitting the x,y points in "sat_03.txt":
cpos = fitcircle("@sat_03.txt", norm=2, coordinates=:mean,  par=(IO_COL_SEPARATOR="/",))
ppos = fitcircle("@sat_03.txt", norm=2, coordinates=:north, par=(IO_COL_SEPARATOR="/",))

# Now we use "project" to project the data in both sat_03.txt and ship_03.txt
# into data.pg, where g is the same and p is the oblique longitude around
# the great circle. We use "km" to get the p distance in kilometers, and "sort"
# to sort the output into increasing p values.
sat_pg  = project("@sat_03.txt",  origin=cpos, pole=ppos, sort=true, outvars=:pz, km=true)
ship_pg = project("@ship_03.txt", origin=cpos, pole=ppos, sort=true, outvars=:pz, km=true)

# Get the common extrema values rounded to 1 km
bounds = round.([max(sat_pg.bbox[1], ship_pg.bbox[1]) min(sat_pg.bbox[2], ship_pg.bbox[2])], digits=0)

samp_x = collect(bounds[1]:bounds[2])
# Now we can resample the gmt projected satellite data:
samp_sat_pg = sample1d(sat_pg, range=samp_x)

# For reasons above, we use filter1d to pre-treat the ship data. We also need to sample
# it because of the gaps > 1 km we found. So we use filter1d | sample1d. We also
# use the "ends" on filter1d to use the data all the way out to bounds :
D = filter1d(ship_pg, filter=:m1, range=(bounds[1], bounds[2], 1), ends=true)
samp_ship_pg = sample1d(D, range=samp_x)

# Now to do the cross-spectra, assuming that the ship is the input and the sat is the output
# data, we do this:
D = spectrum1d([samp_ship_pg[:,2] samp_sat_pg[:,2]], size=256, sample_dist=1,
               wavelength=true, outputs=(:xpower, :ypower, :coherence))

# Time to plot spectra
subplot(grid=(2,1), margins="0.3c", col_axes=(bott=true, label="Wavelength (km)"),
        autolabel=(anchor=:TR, offset="8p"), title="Ship and Satellite Gravity",
        panel_size=10, frame=(axes="WeSn", bg="240/255/240"))
	gmtset(FONT_TAG="18p,Helvetica-Bold",)

	subplot(:set, panel=(1,1), autolabel="Input Power")
	plot(D[:Wavelength, :Xpower, :σ_Xpow], proj=:loglog, flip_axes=:x, xaxis=(annot=1, ticks=3, scale=:pow),
         yaxis=(annot=1, ticks=3, scale=:pow, label="Power (mGal@+2@+km)"), fill="red", marker=:Triangle,
         ms="5p", region=(1,1000,0.1,10000), error_bars=(y=true, pen=0.5), legend="Ship")

	plot(D[:Wavelength, :Ypower, :σ_Ypow], fill="blue", marker=:circ, ms="5p",
         error_bars=(y=true, pen=0.5), legend="Satellite")

	legend(pos=(anchor="BL", offset=0.5), box="+gwhite+pthicker", par=(FONT_ANNOT_PRIMARY="14p,Helvetica-Bold",))
	subplot(:set, panel=(2,1), autolabel="Coherency@+2@+")

	plot(D[:Wavelength, :Coher, :σ_Coher], region=(1,1000,0,1), proj=:logx, flip_axes=:x,
           xaxis=(annot=1, ticks=3, scale=:pow, label="Wavelength (km)"),
           yaxis=(annot=0.25, ticks=0.05, label="Coherency@+2@+"), marker=:circ, ms="5p",
           fill=:purple, error_bars=(y=true, pen=0.5))
subplot(:show)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_1345769521241946342.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide