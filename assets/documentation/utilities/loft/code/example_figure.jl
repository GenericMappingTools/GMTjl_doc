# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT
	
ns=75; t=linspace(0,2*pi,ns); r=5; x=r*cos.(t); y=r*sin.(t); z=zeros(size(x));
C1=[x[:] y[:] z[:]];

f(t) = r + 2.0.* sin(6.0*t)
C2 = [(f(t)*cos(t),f(t)*sin(t),3) for t in range(0, 2pi, ns)];
C2 = stack(C2)'

FV = loft(C1, C2);
viz(FV, pen=0)
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_7940392997823355116.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide