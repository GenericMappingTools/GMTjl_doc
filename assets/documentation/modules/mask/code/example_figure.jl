# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

D = coast(DCW=:HR, dump=true);      # Extract the Croatia border from the DCW
I = gmtread("@earth_day_30s", region=D, V=:q);  # Load Earth image containing Croatia
Ic = mask(I, D);                    # Mask outside (make image transparent there)

gmtwrite("Ic.tiff", Ic)             # For now we need to save and reload to see
Ic = gmtread("Ic.tiff");            # the tranparency in action.

viz(Ic, title="Croatia")
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_9790140833689949690.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide