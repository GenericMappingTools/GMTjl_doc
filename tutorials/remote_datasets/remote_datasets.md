# GMT Remote Datasets 

A remote data set is a data set that is stored on one or more remote servers. It may be a single grid
file or a collection of subset tiles making up a larger grid. They are not distributed with GMT or
installed during the installation procedures. GMT offers several remote global data grids that you
can access via our remote file mechanism. The first time you access one of these files, GMT will
download the file (or a subset tile) from the selected GMT server and save it to the server directory
under your GMT user directory [~/.gmt]. From then on we read the local file from there.

We have processed and reformatted publicly available global data sets (grids and images) and
standardized their file names. In GMT, you may access such data (or a subset only by using the
``region`` option) by specifying the special name

    ``@remote_name_rru[_reg]``

Please refer to the [GMT page](https://docs.generic-mapping-tools.org/dev/datasets/remote-data.html#currently-available-remote-data-sets)
for details of what is the `remote`, `name`, `rru` and `reg` parts of the name. Another very important
aspect is that given the file sizes of the higher resolution versions (can reach out 41 GB), grids with
resolutions higher or equal "5m" (five arc-minutes) are tilled to minimize the amount of necessary download data.

But in order to simplify accessing
these data sets we have a helper function, \myreflink{remotegrid}, that facilitates the name composability.
For example, ``remotegrid("relief", res="6m")`` returns the string``"@earth_relief_06m"`` that can be passed
to modules that create images (``viz``, \myreflink{grdimage}, \myreflink{gmtread}, \myreflink{grdcut}, \myreflink{grdcontour}, etc..)

The examples in next pages show the available dataset and use the ``remotegrid`` function to compose their names
but your, ofc, free to use the full dataset name if you feel comfortable with it.

@@box-container
  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/relief/relief/">~~~
    @@box-content
      @@description
      IGPP Earth Relief
      @@
      ~~~
      <img src="/tutorials/remote_datasets/relief/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/geoid/geoid/">~~~
    @@box-content
      @@description
      EGM2008 Earth Geoid
      @@
      ~~~
      <img src="/tutorials/remote_datasets/geoid/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/age/age/">~~~
    @@box-content
      @@description
      Seafloor Crustal Age
      @@
      ~~~
      <img src="/tutorials/remote_datasets/age/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/mask/mask/">~~~
    @@box-content
      @@description
      GSHHG Earth Mask
      @@
      ~~~
      <img src="/tutorials/remote_datasets/mask/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/dist/dist/">~~~
    @@box-content
      @@description
      GSHHG Earth Distace to Shoreline
      @@
      ~~~
      <img src="/tutorials/remote_datasets/dist/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/wdmam/wdmam/">~~~
    @@box-content
      @@description
      World Digital Magnetic Anomaly Map
      @@
      ~~~
      <img src="/tutorials/remote_datasets/wdmam/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/faa/faa/">~~~
    @@box-content
      @@description
      IGPP Earth Free-Air Anomaly
      @@
      ~~~
      <img src="/tutorials/remote_datasets/faa/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/edefl/edefl/">~~~
    @@box-content
      @@description
      IGPP Earth West-East Defections
      @@
      ~~~
      <img src="/tutorials/remote_datasets/edefl/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/ndefl/ndefl/">~~~
    @@box-content
      @@description
      IGPP Earth South-North Defections
      @@
      ~~~
      <img src="/tutorials/remote_datasets/ndefl/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/vgg/vgg/">~~~
    @@box-content
      @@description
      IGPP Earth Vertical Gravity Gradient
      @@
      ~~~
      <img src="/tutorials/remote_datasets/vgg/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/faa_err/faa_err/">~~~
    @@box-content
      @@description
      IGPP Earth Free-Air Anomaly Error
      @@
      ~~~
      <img src="/tutorials/remote_datasets/faa_err/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/gebco/gebco/">~~~
    @@box-content
      @@description
      GEBCO Earth Relief
      @@
      ~~~
      <img src="/tutorials/remote_datasets/gebco/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/mss/mss/">~~~
    @@box-content
      @@description
      CNES Earth Mean Sea Surface
      @@
      ~~~
      <img src="/tutorials/remote_datasets/mss/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@
  
  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/mdt/mdt/">~~~
    @@box-content
      @@description
      CNES Earth Mean Dynamic Topography
      @@
      ~~~
      <img src="/tutorials/remote_datasets/mdt/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@
  
  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/mag/mag/">~~~
    @@box-content
      @@description
      Earth Magnetic Anomaly Model (EMAG2)
      @@
      ~~~
      <img src="/tutorials/remote_datasets/mag/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/daynight/daynight/">~~~
    @@box-content
      @@description
      NASA Earth Day/Night Images
      @@
      ~~~
      <img src="/tutorials/remote_datasets/daynight/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/mars/mars/">~~~
    @@box-content
      @@description
      NASA Mars Relief
      @@
      ~~~
      <img src="/tutorials/remote_datasets/mars/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/mercury/mercury/">~~~
    @@box-content
      @@description
      USGS Mercury Relief
      @@
      ~~~
      <img src="/tutorials/remote_datasets/mercury/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/moon/moon/">~~~
    @@box-content
      @@description
      USGS Moon Relief
      @@
      ~~~
      <img src="/tutorials/remote_datasets/moon/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/pluto/pluto/">~~~
    @@box-content
      @@description
      USGS Pluto Relief
      @@
      ~~~
      <img src="/tutorials/remote_datasets/pluto/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

  @@box
    ~~~<a class="boxlink" href="/tutorials/remote_datasets/venus/venus/">~~~
    @@box-content
      @@description
      USGS Venus Relief
      @@
      ~~~
      <img src="/tutorials/remote_datasets/venus/tilelogo.jpg">
      ~~~
    @@
    ~~~</a>~~~
  @@

@@