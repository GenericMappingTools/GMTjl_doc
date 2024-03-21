# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT() # hide

# Interpolate data of Mars radius from Mariner9 and Viking Orbiter spacecrafts
makecpt(cmap=:rainbow, range=(-7000,15000))

# Piecewise linear interpolation; no tension
Gtt = sphinterpolate("@mars370d.txt", region=:global, inc=1, tension=0)
grdimage(Gtt, proj=:Hammer, figsize=15, frame=(annot=:auto, grid=:auto), yshift=18)
plot!("@mars370d.txt", marker=:circle, ms=0.1, fill=0, frame=(annot=30, grid=30), yshift=-8)

# Smoothing
Gtt = sphinterpolate("@mars370d.txt", region=:global, inc=1, tension=3)
grdimage!(Gtt, frame=(annot=30, grid=30), yshift=-8, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_524833863411426882.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide