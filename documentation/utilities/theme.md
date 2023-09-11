# theme

```julia
theme(name; kwrgs...)
```

Offer themes support. `name` is the theme name. So far the three options are:

- `modern`: - This is the default theme (same as GMT modern theme but with thinner FRAME_PEN [0.75p])

- `classic`: - The GMT classic theme

- `dark`: - A modern theme variation with dark background.

- `A0|2[XY|XX|YY][atg][ag][g][H][V][NT|nt][ITit][Graph][Dark]` Make a composition of these to select a theme.
   The main condition is that it starts with an A (Annotate). Hence `A2` means annotate two axis
   and `A0` means no axes at all. `XY` means to plot only left and bottom axes, `YY` only left and right
   and `XX` bottom and top. `atg` (or `afg`) means annotate, tick and grid lines. `ag` does not tick.
   `H` and `V` means grid lines will only be horizontal or vertical. Note, these require `atg` or `ag`.
   `NT` stands for no ticks at all and `IT` plots the ticks inside the axes. `Graph` adds a vector
   to the end of each axis (sets `XY`), and `Dark` put the background in dark mode.
   - Example: `A2YYg` -> plot left and right axes (only) and add grid lines.
   - Example: `A2Graph` -> plot left and right axes (only) and adds arrows at the end of them

On top of the modern mode variations (so far `dark` only) one can set the following `kwargs` options:

- `noticks` or `no_ticks`: Axes will have annotations but no tick marks

- `inner_ticks` or `innerticks`: - Ticks will be drawn inside the axes instead of outside.

- `gray_grid` or `graygrid`: - When drawing grid line use `gray` instead of `black`

- `save`: - Save the name in the directory printed by `GMT.GMTuserdir[1]` and make it permanent.

- `reset`: - Remove the saved theme name and return to the default `modern` theme.

Note: Except `save` and `reset`, the changes operated by the `kwargs` are temporary and operate only until
an image is `show`(n) or saved.

This function can be called alone, e.g. `theme("dark")` or as an option in the \myreflink{plot} module.
