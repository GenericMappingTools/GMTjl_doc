# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
text(rich("H", subscript("2"), greek("O")," is the ", smallcaps("formula")," for ",
     rich(underline("water"), color=:red, font="Helvetica", size=16)), x=1, y=1, frame=:none)

str = "A BEAUTIFUL RAINBOW";
C = makecpt(range=(1,length(str)+1,1));
fontsizes = 20 .+ 10 .* sin.(range(0, 3pi, length = length(str)));
rainbow_chars = map(enumerate(str)) do (i, c)
	rich("$c", color = GMT.arg2str(Tuple(round.(Int,C.colormap[i,:].*255))), size = fontsizes[i]);
end
text!(join(rainbow_chars), x=1, y=0.99, font="Helvetica-Bold", show=1)
end # hide
mv(joinpath(tempdir(), "GMTjl_tmp.png"), joinpath(@OUTPUT, "example_968092454105173695.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide