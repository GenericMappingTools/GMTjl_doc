-- GMT cross-reference shortcode
-- Usage: {{< gmtref plot >}} or {{< gmtref gmtread type=util >}}
-- Types: {{< gmtref GMTgrid type=gmttype >}}
-- General: {{< gmtref introduction type=general >}}

return {
  ['gmtref'] = function(args, kwargs)
    -- Get the module/utility/type name
    local name = pandoc.utils.stringify(args[1])

    -- Check for custom display text
    local custom_text = nil
    if kwargs["text"] and pandoc.utils.stringify(kwargs["text"]) ~= "" then
      custom_text = pandoc.utils.stringify(kwargs["text"])
    end

    -- Determine if it's a module, utility, gmttype, or general
    local ref_type = "module"
    if kwargs["type"] then
      ref_type = pandoc.utils.stringify(kwargs["type"])
    end

    -- Known utilities
    local utilities = {
      "ablines", "anaglyph", "append2fig", "autocov", "autocor", "blendimg", "cart2pol", "cart2sph",
      "coastlinesproj", "colorzones", "cpt4dcw", "crop", "cube", "cubeplot", "cylinder",
      "date2doy", "delrows", "df2ds", "dgt_lidar", "dgt_mosaic", "dodecahedron", "doy2date", "ecmwf", "ellipse3D",
      "era5time", "era5vars", "extrude", "findpeaks", "flatfv", "fv2fv",
      "gadm", "geocoder", "geodetic2enu", "getbyattrib", "gmtread", "gmtwrite", "graticules",
      "grid2tri", "gridit", "gunique", "hampel", "hlines", "icosahedron",
      "image_alpha", "image_cpt", "imagesc", "imshow", "ind2rgb", "info",
      "inpolygon", "inwhichpolygon", "isnodata", "isoutlier", "lazread",
      "lazwrite", "leepacific", "lelandshade", "linearfitxy", "listecmwfvars", "loft",
      "logo", "magic", "maregrams", "mat2ds", "mat2grid", "mat2img", "meteostat", "mosaic",
      "octahedron", "ODE2ds", "orbits", "parkergrav", "parkermag", "pastplates",
      "pca", "pcolor", "plotgrid", "plotlinefit", "plotyy", "polygonlevels", "rasterzones",
      "regiongeog", "remotegrid", "replicant", "rescale", "revolve",
      "sealand", "slicecube", "sph2cart", "sphere", "stackgrids", "stereonet",
      "streamlines", "surf2fv", "tetrahedron", "theme", "torus", "uniqueind",
      "vecangles", "vlines", "weather", "whereami", "wmsinfo", "wmsread", "wmstest",
      "worldrectangular", "worldrectcoast", "worldrectgrid", "xyzw2cube", "zonal_stats"
    }

    -- Known Image Processing (otherwise assume module)
    local improcyies = {
      "binarize", "bwareaopen", "bwconncomp", "bwdist", "bwhitmiss", "bwperim", "bwskell", "cc2bw",
      "imdilate", "imerode", "imopen", "imclose", "imtophat", "imbothat", "immorphgrad", "strel",
      "imfilter", "imrankfilter", "imsobel", "graydist", "padarray", "imfill", "imreconstruct",
      "imsegment", "isodata", "imregionalmax", "imregionalmin", "imhmin", "imhmax", "imhdome",
      "fillsinks", "rgb2gray", "rgb2lab", "rgb2ycbcr", "imcomplement"
    }

    -- Auto-detect if it's a utility
    for _, util in ipairs(utilities) do
      if name == util then
        ref_type = "util"
        break
      end
    end

    if ref_type ~= "util" then
      for _, improcy in ipairs(improcyies) do
        if name == improcy then
          ref_type = "imgproc"
          break
        end
      end
    end

    -- Build the path (absolute from site root)
    local path
    local link_content

    if ref_type == "util" then
      path = "/documentation/utilities/" .. name .. ".html"
      link_content = name
    elseif ref_type == "imgproc" then
      path = "/documentation/imgproc/" .. name .. ".html"
      link_content = name
    elseif ref_type == "gmttype" then
      -- GMT types with anchors
      local type_anchors = {
        GMTgrid = "#sec-grid-type",
        GMTimage = "#sec-image-type",
        GMTdataset = "#sec-dataset-type",
        GMTcpt = "#sec-cpt-type",
        GMTps = "#sec-postscript-type",
        GMTfv = "#sec-fv-type"
      }
      path = "/documentation/general/types.html" .. (type_anchors[name] or "")
      link_content = name  -- Use plain name for now
    elseif ref_type == "general" then
      -- General documentation pages
      local general_pages = {
        introduction = "introduction.html",
        ["quick_learn"] = "quick_learn.html",
        modules = "modules.html",
        monolithic = "monolitic.html",
        monolitic = "monolitic.html",  -- Handle both spellings
        types = "types.html"
      }
      path = "/documentation/general/" .. (general_pages[name] or name .. ".html")
      -- Capitalize first letter for display
      link_content = name:gsub("^%l", string.upper):gsub("_", " ")
    else
      path = "/documentation/modules/" .. name .. ".html"
      link_content = name
    end

    -- Use custom text if provided, otherwise use the default link_content
    if custom_text then
      link_content = custom_text
    end

    -- Return a link with the path
    -- Pandoc.Link expects Inlines (list of Inline elements) as first argument
    return pandoc.Link({pandoc.Str(link_content)}, path)
  end
}
