# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

im = gmtread("https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/NGC_3372a-full.jpg/2560px-NGC_3372a-full.jpg");
dedo = gdaltranslate("https://upload.wikimedia.org/wikipedia/commons/f/f8/NGC_3372a-full.jpg", srcwin=1,
                     limits=(10580, 11360, 9410, 10270));
viz(im, inset=(dedo, pzoom=(945, 390), pos=(anchor=:MR,)))
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_7255253521385924773.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide