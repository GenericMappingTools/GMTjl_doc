# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT	# Hide

plot(model, region=(1958,2016,-4,4), frame=(axes=:WSen, bg=:azure1,
      title="The Keeling Curve [CO@-2@- at Mauna Loa]"), xaxis=(annot=:auto, ticks=:auto),
      yaxis=(annot=:auto, ticks=:auto, suffix=" ppm"),
      ms=0.05, fill=:red, incols="0,2", figsize=(12,5))
text!(mat2ds("@~e@~(t) = y(t) - m@-5@-(t)"), font=12, region_justify=:TL,
      offset=(away=true, shift=0.25),fill=:lightyellow, show=true)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_14376759415143716807.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide