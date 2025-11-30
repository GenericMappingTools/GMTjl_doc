# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
GMT.resetGMT() # hide

makecpt(cmap=(255,100), range=(-10,10,10), no_bg=true);
grdcontour("@HI_geoid_04.nc", region=(195,210,18,25), view=(60,30), cont=1,
           annot=(int=5, labels=(rounded=true,)), labels=(dist=10,),
           xshift=3, yshift=3, proj=:merc, figscale=1.1)
coast!(p=true, frame=(annot=2, axes=:NEsw), land=:black,
       rose=(inside=true, anchor=:BR, width=2.5, offset=0.25, label=true))
grdview!("@HI_topo_04.nc", p=true, region=(195,210,18,25,-6,4),
         plane=(-6,:lightgray), surftype=(surf=true, mesh=true), Jz="0.9",
         frame=(axes=:wesnZ, annot=2), zaxis=(annot=2, label="Topo (km)"), yshift=5.6)
text!("H@#awaiian@# R@#idge@#", x=7.5, y=14.0, region=(0,21,0,28),
      font=(60,"ZapfChancery-MediumItalic"), justify=:CB, proj=:linear,
      view=:none, figscale=1, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_9936001676428703525.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide