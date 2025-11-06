# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
subplot(grid="2x2", dims=(size=(15,15), frac=((10,5),(5,10))),
        col_axes=true, row_axes=true)
    n = 200;
    x, y, color = randn(n)/2, randn(n), randn(n);
    histogram(x, limits=(-4,4,0,40), binmethod="sqrt", panel=(1,1));
    scatter(x,y, limits=(-4,4,-4,4), marker=:circ, ms="10p", zcolor=color, panel=(2,1));
    histogram(y, limits=(-4,4,0,40), horizontal=true, binmethod="sqrt", panel=(2,2));
subplot(:show)
	end # hide
	mv(joinpath(TMPDIR_USR.dir, "GMTjl_" * TMPDIR_USR.username * "." * "png"), joinpath(@OUTPUT, "example_10160621470858091473.png"), force=true);    # hide
	GMT.isFranklin[] = false    # hide
	GMT.IamModern[]  = false    # hide
 
	nothing # hide