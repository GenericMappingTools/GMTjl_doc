# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT() # hide

coast(limits=:global, frame=(annot=:a,ticks=:a,grid=:a), proj=:EckertVI,
      area=5000, shore=0.5, borders=(type=1, pen=(0.5,:gray)), water=[175 210 255])
solar!(terminators=(term=:d, date="2016-02-09T16:00:00"), fill="navy@95")
solar!(terminators=(term=:c, date="2016-02-09T16:00:00"), fill="navy@85")
solar!(terminators=(term=:n, date="2016-02-09T16:00:00"), fill="navy@80")
solar!(terminators=(term=:a, date="2016-02-09T16:00:00"), fill="navy@80")

t = solar(sun=(date="2016-02-09T16:00:00",), format=true);
plot!(t, symbol="k@sunglasses/1.5", fill=:yellow, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.tmpdir_usr[2] * "." * "png"), joinpath(@OUTPUT, "example_2037549677329362456.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide