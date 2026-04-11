# FFT tide components.

### Example showing how to extract the two principal tide components, M2 & S2, with Fourier analysis of a one month tide record.

Get a one month maregram from a station in Galicia.

\begin{examplefig}{}
```julia
using GMT	# Hide

D = maregrams(code="fer1", days=30, starttime="2025-04-01T00:00:00");
viz(D, figsize=(14, 6))
```
\end{examplefig}

Resample the data to a constant time step of 60 seconds.

\begin{examplefig}{}
```julia
using GMT	# Hide

Ds = sample1d(D, T="2025-04-01T00:00:00/2025-05-01T00:00:00/60s");
viz(D, figsize=(14, 6))
```
\end{examplefig}

Set the parameters for this time series.

```julia
Fs = 1 / 60;		# Sampling frequency (1 sample per 60 seconds)
L = size(Ds,1);		# Length of signal
```

Find the fundamental periods (tide components) in this tide record.
\begin{examplefig}{}
```julia
using GMT, FFTW
Fs = 1 / 60;		# Hide

D = maregrams(code="fer1", days=30, starttime="2025-04-01T00:00:00");   # Hide
Ds = sample1d(D, T="2025-04-01T00:00:00/2025-05-01T00:00:00/60s");# Hide
L = size(Ds,1);		# Hide

Y = fft(Ds[:,2] .- mean(Ds[:,2]));		# FFTs require that we remove the mean (the zero frequency).
P = abs.(Y/L);
f = Fs * (0:(L/2)-1)/L;

viz(1 ./ f ./ 3600, 2*P[1:length(f)], limits=(0,25,0,1.5), lc=:red, marker=:point, figsize=(15,6))
```
\end{examplefig}

The two frequencies can be found with:


```julia
findpeaks(P, min_height=0.2, xsorted=true)

4-element Vector{Int64}:
    59
    61
 43142
 43144
```

Note that we got four but the last two are repeated as the FFT signal is symetric with respect to the N/2 position.

We can optain the periods in hours with


```julia
ff = fftfreq(L, 1/60);
T1 = 1/(ff[59])/3600

12.41408

T1 = 1/(ff[69])/3600

12.000278
```

Which are the _Principal Lunar (M2)_ and _Principal Solar (S2)_ components.
