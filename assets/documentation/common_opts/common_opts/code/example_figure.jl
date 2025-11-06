# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
basemap(region="-30/30/-20/20", figsize=(12,8),
        frame=(annot=:a, ticks=:a, xlabel="Standard horizontal label", Yhlabel="@~Y(q)@~",
               title="Vertical Y-axis label"), show=1)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_9837621023515778585.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide