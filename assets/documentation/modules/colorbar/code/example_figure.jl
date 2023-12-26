# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

C = makecpt(cmap=:jet, range=(0,100));
basemap(region=(0,30,0,45), frame=(axes=:wsne, annot=:auto, ticks=:auto))
colorbar!(position=(inside=true, anchor=:BC), xaxis=(annot=:auto, ticks=:auto),
          box=(pen=(0.25,:red),), ylabel="@.C", cmap=C)
colorbar!(position=(outside=true, anchor=:BC), box=(pen=(0.25,:red),), ylabel="@.C", cmap=C)
colorbar!(position=(inside=true, anchor=:TC), box=(pen=(0.25,:red),), ylabel="@.C", cmap=C)
colorbar!(position=(outside=true, anchor=:TC), box=(pen=(0.25,:red),), ylabel="@.C", cmap=C)
colorbar!(position=(inside=true, anchor=:ML), box=(pen=(0.25,:red),), ylabel="@.C", cmap=C)
colorbar!(position=(outside=true, anchor=:ML), box=(pen=(0.25,:red),), ylabel="@.C", cmap=C)
colorbar!(position=(inside=true, anchor=:MR), box=(pen=(0.25,:red),), ylabel="@.C", cmap=C)
colorbar!(position=(anchor=:MR,), box=(pen=(0.25,:red),), ylabel="@.C", cmap=C, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_1910576735034195222.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide