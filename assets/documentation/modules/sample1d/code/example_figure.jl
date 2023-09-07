# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
mat = [0 0; 1 1; 2 1.5; 3 1.25; 4 1.5; 4.5 3; 5 2; 6 2.5];
gmtbegin()
    D = sample1d(mat, inc=0.01, interp=:cubic);
    plot(D, region=(-0.1,6.1,-0.1,3.1), figsize=(14,6), xlabel=:u, ylabel="u(x)", lw=1, legend="Cubic spline (F=:c)")
    D = sample1d(mat, inc=0.01, interp=(:smooth, 1));
    plot!(D, lw=1, lc=:orange, legend="Smooth cubic spline (F=:s1)")
    D = sample1d(mat, inc=0.01, interp=:linear);
    plot!(D, lw=1, lc=:blue, legend="Linear spline (F=:l)")
    D = sample1d(mat, inc=0.01, interp=:akima);
    plot!(D, lw=1, lc=:red, legend="Akima spline (F=:a)")
    D = sample1d(mat, inc=0.01, interp=:nointerp);
    plot!(D, lw=1, lc=:darkgreen, legend="Nearest neighbor (F=:n)")
    plot!(mat, marker=:circ, ms=0.25, mc=:red, ml=:thin, legend="Data")
    legend(position=(inside=:TL, width=4.9, offset=0.2), box=(pen=1, fill=:white, shaded=true))
gmtend(:show)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_8324852696282520006.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide