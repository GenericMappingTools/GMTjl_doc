# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

I = grdimage(Gwib, C=:earth, img_out=true);		# Hide
Iblend = gmtread("https://oceania.generic-mapping-tools.org/cache/wiberia_shade_blender.png");	# Hide
# Blend the tint and the shades (darken)
Iburn = blendimg!(I, Iblend, mode="LinearBurn", new=true);

# Apply illunination to the previous image
Ib = blendimg!(Iburn, Iblend, mode="Screen", new=true);

viz(Ib, coast=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_9095517609425410923.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide