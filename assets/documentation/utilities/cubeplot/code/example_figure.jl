# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT

cubeplot(GMT.TESTSDIR * "assets/seila_gray.jpg",
         GMT.TESTSDIR * "assets/seis_section_rgb.jpg",
         GMT.TESTSDIR * "assets/seis_section_gray.jpg",
         zsize=6, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_11823044619417765887.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide