# magref

```julia
    magref(cmd0::String=""; kwargs...)
```

*keywords: GMT, Julia, Geomagnetic, IGRF, CM4*

Description
-----------

Evaluates the IGRF or the CM4 geomagnetic models at the specified locations and times.

Required Arguments
------------------

None.

Optional Arguments
------------------

*input*
    Contains the moments in space-time where we want to evaluate the magnetic reference field.
    The first two columns must contain longitude and latitude (however, see **yx** for latitude and
    longitude instead). Normally, the third and fourth columns must contain altitude (in km) and time,
    respectively, but if one or both of these are constant for all records they can be supplied via the
    **adjust** option instead and are thus not expected in the input file. The alternative to provide the
    _x,y_ locations is to use the **region** and (when grids are not global) the **inc** options.
    With them we get the results in a grid form. It requires setting *time* and *altitude* via the
    **adjust** option. 
    
    A note about the CM4 validity domain. The core field of CM4 is valid from 1960-2002.5 but the
    ionospheric and magnetospheric fields are computed after the *Dst* and *F10.7* coefficient files.
    We extended here those coefficient files up to 2006, which means that one can compute external
    contributions up until 2006 but the Secular Variation will be biased (non reliable). New indices
    files may be retrieved from from:ftp://ftp.ngdc.noaa.gov/STP/GEOMAGNETIC_DATA/INDICES/DST/ (the *Dst* coefficients)
    and http://umbra.nascom.nasa.gov/sdb/yohkoh/ys_dbase/indices_flux_raw/Penticton_Absolute/monthly/MONTHPLT.ABS
    (The *F10.7* index file is a MONTHPLT.ABS). **Note**: since the *Dst* files in the .../DST/ directory
    are still only up to 2006, for GMT4.5.3 and after we extended the *Dst* until August 2009 by reformatting
    the data in the preliminary file Est_Ist_index_0_mean.pli, which is at
    ftp://ftp.ngdc.noaa.gov/STP/GEOMAGNETIC_DATA/INDICES/EST_IST/. But since
    this site is now also outdated, we get the DST indices from
    http://wdc.kugi.kyoto-u.ac.jp/dstae/index.html However, for the most recent dates those indices are
    "Quick Look" (the best are the "Definitive" type).  Because the *F10.7* from the MONTHPLT.ABS file mentioned
    above are apparently no being updated, we found another place where they are, which is:
    ftp://ftp.ngdc.noaa.gov/STP/space-weather/solar-data/solar-features/
    solar-radio/noontime-flux/penticton/penticton_absolute/listings/
    listing_drao_noontime-flux-absolute_monthly.txt

    Another update in January 2025. The NASA site above no longer updated its data and now we use *F10.7* data
    downloaded from https://celestrak.org/spacedata/SW-All.csv  (Matlab refences this site as well). But it
    contains only daily data. Hence we computed the montly averages. However, comparing previous and computed
    averages from this site show some differences. For example the first 4 months of 2018 (replaced to in this
    update) compare like this: [609 632 608 634] (nasa) _vs_ [699 725 683 700] (celestrak).

- **A** or **adjust** : -- *input_params=(alt|altitude=true, onetime=true, yeardec=true)*\
    Adjusts how the input record is interpreted. Use **alt=true** to set a fixed *altitude* (in km) that should
    apply to all data records [Default expects *altitude* to be in the 3rd column of all records]. Use
    **onetime=true** to set a fixed *time* that should apply to all data records [Default expects *time* to be in
    the 4th column of all records]. Finally, use **yeardec=true** to indicate that all times are specified as
    decimal years [Default is ISO _date_T_colck_ format, see
    [IME_EPOCH](https://docs.generic-mapping-tools.org/dev/gmt.conf.html#term-TIME_EPOCH)].\
    **NOTE**: This basically only applies when passing data via a file, where we have no chance to know if time
    was passed as decimar years or as a DateTime string. When passing data directly in numeric form, we try to
    guess all this for you. So, for example, you can do `magref([-28 38 0 "2001-05-01T12:00:00"], internal=...)`
    or `magref([-28 38 0 2001.330137], ...)` and we do the guessings. If input has only two columns, we assume
    an altitude of zero and current time.

- **C** or **cm4file** : -- *cm4file=file*\
    Specify an alternate CM4 coefficient file [umdl.CM4].

- **D** or **dstfile** : -- *dstfile=file*
    Specify an alternate file with hourly means of the Dst index for CM4 [Dst_all.wdc].
    Alternatively, simply specify a single index to apply for all records.

- **E** or **f107file** : -- *f107file=file*
    Specify an alternate file with monthly means of absolute F10.7 solar radio flux for CM4 [F107_mon.plt].
    Alternatively, specify a single flux to apply for all records.

- **F** or **internal** : -- *internal=flags* **|** *internal=(all_input=true, total|T=true, horizontal|H=true, X=true, Y=true, Z=true, dec|declination=true, inc|inclination=true, IGRF=true, CM4core=true, CM4litho=true, CM4mag_p=true, CM4mag_i=true, CM4iono_p=true, CM4iono_i=true, CM4toroid=true, IGRG_CM4=true)*\
    Selects output items; Use, **in alternative**, the expanded form or the *flags* string made up of one or more of these characters:
      - **r** or **all_input=true** means output all input columns before adding the items below
      - **t** or **total|T=true** means list total field (nT).
      - **h** or **horizontal|H=true** means list horizontal field (nT).
      - **x** or **X=true**  means list X component (nT, positive north).
      - **y** or **Y=true**  means list Y component (nT, positive east).
      - **z** or **Z=true**  means list Z component (nT, positive down).
      - **d** or **dec|declination=true**  means list declination (deg, clockwise from north).
      - **i** or **inc|inclination=true**  means list inclination (deg, positive down).
    Select requested field contribution(s) using either the keyword **or** append one or more numbers after a slash (**/**):
      - **0** or **IGRF=true**  means IGRF field (no combinations allowed)
      - **1** or **CM4core=true**  means CM4 Core field
      - **2** or **CM4litho=true**  means CM4 Lithospheric field
      - **3** or **CM4mag_p=true**  means CM4 Primary Magnetospheric field
      - **4** or **CM4mag_i=true**  means CM4 Induced Magnetospheric field
      - **5** or **CM4iono_p=true**  means CM4 Primary ionospheric field
      - **6** or **CM4iono_i=true**  means CM4 Induced ionospheric field
      - **7** or **CM4toroid=true**  means CM4 Toroidal field
      - **9** or **IGRG_CM4=true**  means Core field from IGRF and other contributions from CM4.
    Do **not** use both **IGRF** and **IGRG_CM4** (or **0** and **9**).

    Using several of the fiels contribution options (or appending several numbers (1-7)) will add up the different
    contributions. For example **internal=(total=true, CM4core=true, CM4litho=true)** (or **internal=t/12**)
    computes the total field due to Core and Lithospheric sources. The special case, that mixes Core field from
    IGRF and other sources from CM4, **internal=t/934** computes Core field due to IGRF plus terms 3 and 4
    from CM4 (but you can add others). This case is very important to be able to continue to use the CM4 model
    outside of its original time validity limits. The data is written out in the
    order they appear in *flags* [Default is **F=rthxyzdi/1**].

- **G** or **geocentric** : -- *geocentric=true*\
    Specifies that coordinates are geocentric [geodetic].

\textinput{common_opts/opt_I}

- **L** or **external** : -- *external=(all_input=true, total|T=true, X=true, Y=true, Z=true, mag_i=true, iono_p=true, iono_i=true, poloidal=true)*\
    Computes J field vectors from certain external sources.
      - **r** or **all_input=true** means output all input columns before adding the items below (all in Ampers/m).
      - **t** or **total|T=true** means list magnitude field.
      - **x** or **X=true** means list X component.
      - **y** or **Y=true** means list Y component.
      - **z** or **Z=true** means list Z or current function Psi.
    Append a number to indicate the requested J contribution:
      - **1** or **mag_i=true** means Induced Magnetospheric field.
      - **2** or **iono_p=true** means Primary ionospheric field.
      - **3** or **iono_i=true** means Induced ionospheric field.
      - **4** or **poloidal=true** means Poloidal field.

\textinput{common_opts/opt_R}

- **Sc** or **core_coef** : -- *core_coef=(low,high)*\
    Limits the wavelengths of the core field contribution to the band
    indicated by the low and high spherical harmonic order [1/13].

- **Sl** or **litho_coef** : -- *litho_coef=(low,high)*\
    Limits the wavelengths of the lithosphere field contribution to the
    band indicated by the low and high spherical harmonic order [14/65].

\textinput{common_opts/opt_V}

\textinput{common_opts/opt_bi}

\textinput{common_opts/opt_h}

\textinput{common_opts/opt_o}

\textinput{common_opts/opt_yx}
.. include:: ../../explain_colon.rst_

Time Settings
-------------

If binary input files are used then absolute time are stored as time relative to the
selected epoch. However, since the epoch used is not stored in the data files there
can be problems decoding the correct time. The mgd77 supplement uses the Unix time
system as its default; thus you should make sure that binary data files with time
uses the same system (see the GMT default TIME_SYSTEM).

Examples
--------

To get the CM4 Total field, Declination and Inclination due to all but lithospheric
and toroidal field at a one point location and decimal time 2000.0, do

```julia
magref([-28 38 0 2000.0], internal=(T=true, dec=true, inc=true, CM4core=true, CM4litho=true, CM4mag_p=true))
1×3 GMTdataset{Float64, 2}
 Row │   col.1     col.2   col.3
─────┼───────────────────────────
   1 │ 43795.6  -12.1047  54.178
```

To do the same as above but at noon (Universal Time) of first May 2001, try
(note, we now use the condensed form of specifying the field components):

```julia
D = magref([-28 38 0 "2001-05-01T12:00:00"], internal="tdi/123")
1×3 GMTdataset{Float64, 2}
 Row │   col.1    col.2    col.3
─────┼───────────────────────────
   1 │ 43758.0  -11.866  54.0388
```

And to see the IGRF field at 2025.0. Since we are not specifying the grid increments
(**inc**) it will assume a **inc=0.25** degrees.

\begin{examplefig}{}
```julia
using GMT

G = magref(R=:d, onetime=2025);
viz(G, coast=true, colorbar=true)
```
\end{examplefig}

See Also
--------

\myreflink{mgd77track}

References
----------

Comprehensive Modeling of the Geomagnetic Field, see
`<https://doi.org/10.1111/j.1365-246X.2004.02421.x>`_.

The International Geomagnetic Reference Field (IGRF), see
`<https://www.ngdc.noaa.gov/IAGA/vmod/igrf.html>`_.
