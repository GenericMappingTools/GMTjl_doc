<!--
Add here global page variables to use throughout your website.
-->
+++
author = "GMT.jl"
mintoclevel = 2
frontpage = false
auto_code_path = true

# prepath = "GMTjl_doc"

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/", "misc/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "Franklin Template"
website_descr = "Example website using Franklin"
prepath = get(ENV, "PREVIEW_FRANKLIN_PREPATH", "GMTjl_doc")
# website_url = get(ENV, "PREVIEW_FRANKLIN_WEBSITE_URL", "fct-gmt.ualg.pt")
website_url = get(ENV, "PREVIEW_FRANKLIN_WEBSITE_URL", "www.generic-mapping-tools.org")
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}

<!-- myreflink{Basic Tutorial} expands to [Basic Tutorial](link_to_that) -->
\newcommand{\myreflink}[1]{[!#1](\reflink{!#1})}

\newcommand{\figenv}[3]{
~~~
<figure style="text-align:center;">
<img src="!#2" style="padding:0;#3" alt="#1"/>
<figcaption>#1</figcaption>
</figure>
~~~
}

\newcommand{\apilink}[1]{[`!#1`](/api/#!#1)}
