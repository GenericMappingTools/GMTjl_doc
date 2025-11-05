# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

im = gmtread("https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/NGC_3372a-full.jpg/2560px-NGC_3372a-full.jpg");
dedo = gdaltranslate("https://upload.wikimedia.org/wikipedia/commons/f/f8/NGC_3372a-full.jpg", srcwin=1,
                     limits=(10580, 11360, 9410, 10270));
viz(im, inset=(dedo, pzoom=(945, 390), pos=(anchor=:MR,)))
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_1074259813995056133.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide