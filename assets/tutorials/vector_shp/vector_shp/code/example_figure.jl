# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT   # Hide
munic = gmtread(GMT.TESTSDIR * "COL_adm2.shp.zip");		# Hide
mun_antioquia = filter(munic, NAME_1=:Antioquia);		# Hide
antioquia_points = centroid(mun_antioquia);				# Hide
t = info(mun_antioquia, att="ID_2");					# Hide
antioquia_points.text = t;					            # Hide
# Convert t to numeric. Needed for creating a color map and make the choropleth style plot.
tn = parse.(Int,t);

# Create a color map
C = makecpt(range=(minimum(tn),maximum(tn)), C=:bamako);

# Vizualize 
viz(mun_antioquia, proj=:guess, levels=tn, cmap=C, lw=0, title="Another Map of Antioquia", text=(data=antioquia_points, font=5), colorbar=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_6832767284945348136.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide