# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
GMT.resetGMT() # hide

Cgeoid = grd2cpt("@india_geoid.nc");
Cgray  = makecpt(cmap=150, range="-10000,10000", nobg=true);
sealand(grdimage, "@india_geoid.nc", (region="@india_geoid.nc", shade="+d", proj=:Merc,
                                      cmap=Cgeoid, title="Clipping of Images"),
        grdimage, "@india_topo.nc", (shade="+d", cmap=Cgray), shore=0.5)
colorbar!(pos=(inside=true, anchor=:TR, offset=(0.8,0.2), size=(10,0.5), horizontal=true),
          cmap=Cgeoid, xaxis=(annot=5, ticks=1), ylabel=:m, shade=true)

# Add a text paragraph
t = ["@_@%5%Example 17.@%%@_  We first plot the color geoid image"
    "for the entire region, followed by a gray-shaded @#etopo5@#"
    "image that is clipped so it is only visible inside the coastlines."]
text!(mat2ds(t, hdr="> 90 -10 12p 8c j"), paragraph=true, fill=:white, pen=:thinner,
      clearance=(round=true,), offset=(-0.25,0.25), font=(12,"Times-Roman"), justify=:RB, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_12641759100786255793.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide