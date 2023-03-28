# gmtset

```julia
gmtset(; kwargs...)
```

Change individual GMT default settings

Description
-----------

Adjusts individual GMT defaults settings in the current directory's
[gmt.conf](https://docs.generic-mapping-tools.org/dev/gmt.conf.html) file (under classic mode)
or in the current session directory (modern mode). If no such file exists one will be created.
The main purpose of **set** is temporarily to change certain parameters inside a shell script,
e.g., set the map frame type to plain, run the script, and reset to fancy.  Only parameters
that differ from the GMT SI system defaults will be written. Optionally, you can specify one or more
temporary changes directly on any GMT command line with the syntax `conf=(PARAMETER = VALUE, ...)`;
such changes are only in effect for that command and do not permanently change the default settings on disk.

Required Arguments
------------------

PARAMETER *value*
    Provide one or several pairs of parameter/value combinations that you want to modify.
    For a complete listing of available parameters and their meaning, see the
    [gmt.conf](https://docs.generic-mapping-tools.org/dev/gmt.conf.html) man page.

Optional Arguments
------------------

- **D** or **units** : -- *units=true* **|** *units=:s*  **|** *units=:u*\
    Modify the GMT defaults based on the system settings. Use **units=:u** for US defaults or
    **units=:s** for SI defaults. [**units** alone gives the version selected at compile time]

**-G** or **defaultsfile** : -- *defaultsfile=file*\
    Name of specific [gmt.conf](https://docs.generic-mapping-tools.org/dev/gmt.conf.html) file to read
    and modify [Default looks first in current directory, then in your home directory, then in
    ~/.gmt and finally in the system defaults].

Examples
--------

To change annotation font to 12-point Helvetica, select grid-crosses of
size 0.25 cm, and set annotation offset to 0.2 cm

```julia
    gmtset(FONT_ANNOT_PRIMARY=(12,Helvetica), MAP_GRID_CROSS_SIZE_PRIMARY=0.2.5, MAP_ANNOT_OFFSET_PRIMARY=0.2)
```

See Also
--------

[gmt.conf](https://docs.generic-mapping-tools.org/dev/gmt.conf.html),
\myreflink{gmtdefaults}, \myreflink{gmtget}
