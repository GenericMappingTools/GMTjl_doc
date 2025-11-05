# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT, FFTW		# Hide
Fs = 50000;     # Hide
T = 1/Fs;       # Hide
L = 10000;      # Hide
t = (0:L-1)*T;  # Hide
A1 = 325;		# Hide
f1 = 50;		   # Hide
A2=200;			# Hide
f2=400;			# Hide
A3=150;			# Hide
f3=800;			# Hide
sig1 = A1*sin.(2*pi*f1*t);	# Hide
sig2 = A2*sin.(2*pi*f2*t);# Hide
sig3 = A3*sin.(2*pi*f3*t);# Hide
final= sig1 .+ sig2 .+ sig3;	# Hide
Y = fft(final);		# Hide

Yfilt = copy(Y);
Yfilt[20:end] .= 0;
inv = ifft(Yfilt);
viz(real(inv), figsize=(14,6))
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_13840207710349751300.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide