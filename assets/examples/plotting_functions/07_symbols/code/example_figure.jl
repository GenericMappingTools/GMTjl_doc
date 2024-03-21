# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
plot([0.5 0.5 30 100], limits=(0,6,0,3), figscale=2.5, frame="afg",
     marker=:wedge, ms=5, fill=:lightyellow, ml=2, title="Spiders")
plot!([2.5 0.5 30 100], marker=:wedge, ms=5, fill=:yellow)
plot!([0.5 1.75 30 100], marker=(web=true, size=5, arc=0.7, pen=(0.5,:red)), ml=1)
plot!([2.5 1.75 30 100], marker=(web=true, size=5, radial=15),
      fill=:lightyellow, ml=0.5)
# But we can also send the Web angle info via marker and use a Tuple as argument.
plot!([4.5 1.75], marker=(:web, [30 330], (size=5, arc=0.7, radial=15, pen=0.25)),
      fill=:pink, ml=1, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_11804576336333863751.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide