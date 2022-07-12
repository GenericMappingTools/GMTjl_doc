# This file was generated, do not modify it. # hide
begin # hide
	using GMT   # hide
	GMT.isFranklin[1] = true    # hide
	getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
	using GMT

a = atand(4 / 2.5)
X = project([0 0], origin=(0,-1), endpoint=(2.5,3), flat_earth=true)
plot([-1.5 -1.0625; 0 -2; 2 1.2; 0.5 2.1375], region=(-3.5,4,-2.7,2.6), fill=:lightgray,
     xlabel="@%7%x@%% or @%7%r@%%", ylabel="@%7%y@%% or @%7%s@%%", figsize="12/0")
plot!([0 -1; 2 2.2], marker=:circ, ms=0.3, fill=:orange, frame=(grid=10,))
arrows!([0 -1 2 2.2; 0 -1 -2.5 0.5625], arrow=(len=16, stop=true, shape=1, endpoint=true),
        lw=2, fill=:black)
plot!([0 0], marker=:circ, ms=0.3, fill=:red)
# Get coordinates of the (0,q) point as well so we can dash the line 
x = -X[4] * sind(a)
y =  X[4] * cosd(a) - 1
plot!([X[5] X[6]], marker=:circ, ms=0.2, fill=:blue)
T = mat2ds([ 0   -1      0;
             2    2.2    0;
             1.9  1.9    a;
            -2.3  0.4    a;
             2    1.2    a;
             0   -2      a;
             0   -2      a;
            -1.5 -1.0625 a;
            0.45  0.8   -16],
           ["TL @%7%C@%%", "BR @%7%E@%%", "TC p", "RM q", "TC L@-max@-",
            "TC L@-min@-", "RB W@-min@-", "RM W@-max@-", "TC @~a@~"])
text!(T, font=(12, "Times-Italic"), angle="", justify="", offset=(away=true, shift=0.15))
plot!([0 0; X[5] X[6]], pen=(0.25, :red, :dash))
plot!([0 0; x y], pen=(0.25, :red, :dash))
plot!([0.0 -1], marker=(:matangle, [2.54 a 90], (length=9, start=true)), ml=0.5, fill=:black)
showfig()
end # hide
mv(joinpath(tempdir(), "GMTjl_tmp.png"), joinpath(@OUTPUT, "example_13153675526802474808.png"), force=true);    # hide
GMT.isFranklin[1] = false    # hide
GMT.IamModern[1]  = false    # hide
 
nothing # hide