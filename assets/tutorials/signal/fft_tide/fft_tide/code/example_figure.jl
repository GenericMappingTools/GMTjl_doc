# This file was generated, do not modify it. # hide
begin # hide
		using GMT   # hide
		GMT.isFranklin[1] = true    # hide
		getpath4docs(file::String) = joinpath("..", "..", "..", "..", "..", file) # hide
		using GMT, FFTW
Fs = 1 / 60;		# Hide

D = maregrams(code="fer1", days=30, starttime="2025-04-01T00:00:00");   # Hide
Ds = sample1d(D, T="2025-04-01T00:00:00/2025-05-01T00:00:00/60s");# Hide
L = size(Ds,1);		# Hide

Y = fft(Ds[:,2] .- mean(Ds[:,2]));		# FFTs require that we remove the mean (the zero frequency).
P = abs.(Y/L);
f = Fs * (0:(L/2)-1)/L;

viz(1 ./ f ./ 3600, 2*P[1:length(f)], limits=(0,25,0,1.5), lc=:red, marker=:point, figsize=(15,6))
	end # hide
	mv(joinpath(tempdir(), "GMTjl_" * GMT.TMPDIR_USR[2] * "." * "png"), joinpath(@OUTPUT, "example_15685902757269880473.png"), force=true);    # hide
	GMT.isFranklin[1] = false    # hide
	GMT.IamModern[1]  = false    # hide
 
	nothing # hide