    - **clearance=val** where *val* is either *gap* or *(xgap,ygap)*, or *(lgap,rgap,bgap,tgap)* where these items are uniform, separate in x- and y-direction, or individual side spacings between the map embellishment and the border for each side.
    
    - **fill=color**, where *color* is any valid color setting (see \myreflink{Setting color}, to fill the scale panel [no fill].
    
    - **inner=true** to draw a secondary, inner border as well. We use a uniform *gap* between borders of *2p* and the `MAP_DEFAULTS_PEN` unless other values are specified (like **inner="gap/pen"**). 
    
    - **pen=pen**, to specify different \myreflink{Pen attributes} attributes.
    
    - **rounded=true** to draw rounded rectangular borders instead, with a *6p* corner radius. You can override this radius by using another value instead of *true*.
    
    - **shadded=true** or **shadded=(dx,dy)** or **shadded=shade** to draw an offset background shaded region. Here, *dx/dy* indicates the shift relative to the foreground frame [*4p/-4p*]and *shade* sets the fill style to use for shading ("gray50").