# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

x = -8:0.01:6;
y = 0.15 .* x;
z = 50 .* exp.(-((x ./ 3) .^ 2)) .* cos.(2pi .* x) .+ y;
wiggle([x y z], region=(-10,10,-3,3), proj=:Merc, ampscale=100,
       scale_bar=(refpoint=:RM, width=100, label=:nT),
       track=:faint, fill=["red+p", "blue+n"], pen=1, show=1)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_17140836888534770604.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide