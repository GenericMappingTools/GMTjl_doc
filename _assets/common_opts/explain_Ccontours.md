- **C** or **cont** or **contours** or **levels** : -- *cont=cont\_int*\
  The contours to be drawn may be specified in one of four possible ways:
    1. If ``cont_int`` has the suffix ".cpt" and can be opened as a file, it is assumed to be a CPT.
       The color boundaries are then used as contour levels. If the CPT has annotation flags in the
       last column then those contours will be annotated. By default all contours are labeled;
       use *annot=(disable=true,))* (or *annot=:none*) to disable all annotations.
    2. If ``cont_int`` is a file but not a CPT, it is expected to contain contour levels in column 1 and a
       C(ontour) OR A(nnotate) in col 2. The levels marked **C** (or **c**) are contoured, while the levels
       marked **A** (or **a**) are contoured and annotated. If the annotation *angle* is present we will
       plot the label at that fixed angle [aligned with the contour]. Finally, a contour- specific *pen*
       may be present and will override the pen set by **pen** for this contour level only. **Note**:
       Please specify *pen* in proper format so it can be distinguished from a plain number like *angle*.
       If only *cont-level* columns are present then we set type to **C**
    3. If ``cont_int`` is a constant or an array it means plot those contour intervals. This works also to draw
       single contours. *E.g.* **contour=[0]** will draw only the zero contour. The **annot** option offers the same
       list choice so they may be used together to plot a single annotated contour and another single non-annotated contour,
       as in **anot=[10], cont=[5]** that plots an annotated 10 contour and an non-annotated 5 contour. If **annot** is set
       and **cont** is not, then the contour interval is set equal to the specified annotation interval.
    4. If no argument is given in modern mode then we select the current CPT.
    5. Otherwise, ``cont_int`` is interpreted as a constant contour interval.

  If a file is given and **ticks** is set, then only contours marked with upper case **C** or **A**
  will have tick-marks. In all cases the contour values have the same units as the grid. Finally,
  if neither **cont** nor **annot** are set then we auto-compute suitable contour and annotation
  intervals from the data range, yielding 10-20 contours.
