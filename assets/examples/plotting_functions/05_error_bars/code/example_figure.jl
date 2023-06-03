# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

C = makecpt(range=(0,6,1));
t = [1 1 1 1
    2 2 2 1
    3 3 3 1
    4 4 4 1
    5 5 5 1];
plot(t, limits=(0,6,0,6), figsize=7, frame=:noannot, marker=:circle, ms=0.5,
     color=C, ml=0.25, error_bars=(x=:x, pen=(2,:red)), yshift=5)
plot!(t, frame=:noannot, marker=:circle, ms=0.5, color=C, ml=0.25,
      error_bars=(y=:y, pen=1, cline=true), xshift=7.5)
# Use the color map to paint the symbol marker line
plot!(t, frame=:noannot, marker=:circle, ms=0.5, color=C,
      ml=(lw=5, colored=true), error_bars=(y=:y, pen=1, csymbol=true),
      xshift=-7.5, yshift=7.5)
# Pretend our data array has only the coordinates and pass color col & errors via args
tt = t[:,1:2]
plot!(tt, frame=:noannot, marker=:circle, ms=0.5, color=C, mz=[1 2 3 4 5],
      ml=(0.25,:red), error_bars=(x=ones(5,1), pen=1, cline=true),
      xshift=7.5, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * ".png"), joinpath(@OUTPUT, "example_14257199142537921579.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide