# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
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
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_9095517609425410923.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide