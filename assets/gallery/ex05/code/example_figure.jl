# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT
resetGMT() # hide

Gsombrero = gmt("grdmath -R-15/15/-15/15 -I0.3 X Y HYPOT DUP 2 MUL PI MUL 8 DIV COS EXCH NEG 10 DIV EXP MUL =");
C = makecpt(color=128, range=(-5,5), no_bg=true);
grdview(Gsombrero, limits=(-15,15,-15,15,-1,1), frame=(axes="SEwnZ", annot=5),
        zaxis=(annot=0.5,), plane=(-1, :white), surftype=:surface,
        shade=(azim=225, norm="t0.75"), figsize=12, zsize=5, view=(120,30))
tit = mat2ds([7.5 12], "z(r) = cos (2@~p@~r/8) @~\\327@~e@+-r/10@+");
text!(tit, limits=(0,21,0,28), proj=:linear, view=:none,
      font=(50,"ZapfChancery-MediumItalic"), justify=:CB, scale=1, show=true)
end # hide
mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_6890047330486406257.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide