# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
# Poly-line arround which to compute the buffer. Make it go arround the pole.
line = [-37. 1; -28 26; -45 35; -19 42; -9 55; 4 64; 32 72; 85 73; 135 73; 172 73; -144 73; -78 77; -27 72; -8 65; 8 54; 18 39; 28 24; 34 1];
D = buffergeo(line, width=500000);  # Compute the buffer polygon
coast(region=:global, land=:peru, frame=:g,
      proj=(name=:ortho, center=(0,45)),
      plot=(data=D, fill=:green), show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_8571589198303415337.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide