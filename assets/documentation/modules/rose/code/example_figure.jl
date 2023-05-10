# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
    rose("@azimuth_lengths.txt", yx=true, sectors=5, no_scale=true, labels=true,
         fill=:lightblue, region=(0,1,0,180), xaxis=(annot=true, ticks=true, label="Fault length"),
         yaxis=(grid=30,), norm=true, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * ".png"), joinpath(@OUTPUT, "example_12662338116092347759.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide