# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
coast(region=:d, proj="Ks0/12", resolution=:low, area=5000, borders="1/0.5p,gray",
      water=(175,210,255), axes=(annot=:a,ticks=:a,grid=:a), shore=0.5) 
solar!(terminators=(term=:d, date="2016-02-09T16:00:00"), fill="navy@95")
solar!(terminators=(term=:c, date="2016-02-09T16:00:00"), fill="navy@85")
solar!(terminators=(term=:n, date="2016-02-09T16:00:00"), fill="navy@80")
solar!(terminators=(term=:a, date="2016-02-09T16:00:00"), fill="navy@80", show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_14084592095356389010.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide