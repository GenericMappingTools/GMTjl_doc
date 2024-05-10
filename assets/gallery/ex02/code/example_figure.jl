# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
GMT.resetGMT() # hide

gmtset(FONT_TITLE=30, MAP_ANNOT_OBLIQUE=0)
g_cpt = makecpt(color=:rainbow, T=(-2,14,2))
grdimage("@HI_geoid_02.nc", region_diag=(160,220,20,30),
         proj=(name=:omercp, center=[190 25.5], parallels=[292 69]),
         dpi=50, frame=(annot=10,), xshift=3.8, yshift=3.2, figsize=12)
colorbar!(pos=(anchor=:RM, offset=(1.5,0), triangles=true, neon=true),
          xaxis=(annot=2, label=:GEOID), yaxis=(label=:m,))
		
# Now the topography map
t_cpt = grd2cpt("@HI_topo_02.nc", cmap=:relief, continuous=true)
grdimage!("@HI_topo_02.nc", frame=(title="H@#awaiian@# T@#opo and @#G@#eoid@#", annot=10),
          shade="+a0", dpi=50, yshift=11, par=(:MAP_TITLE_OFFSET, 1.25))
colorbar!(pos=(anchor=:RM, offset=(1.5,0), neon=true), shade=0.3,
          xaxis=(annot=2, label=:TOPO), yaxis=(label=:km,))
T = mat2ds([-0.4 7.5; -0.4 3.0], ["a)", "b)"])
pstext!(T, region=(0,21.6,0,29.94), font=(30,"Helvetica-Bold"), justify=:CB,
        yshift=11, proj=:linear, scale=1, show=true)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_4423643730670146179.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide