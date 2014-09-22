# ALA4R

The Atlas of Living Australia (ALA) provides tools to enable users of biodiversity information to find, access, combine and visualise data on Australian plants and animals; these have been made available from http://www.ala.org.au/. Here we provide a subset of the tools to be directly used within R.

ALA4R enables the R community to directly access data and resources hosted by the Atlas of Living Australia (ALA: http://ala.org.au/). Our goal is to enable outputs (e.g. observations of species) to be queried and output in a range of standard formats.

The use-examples presented at the [2014 ALA Science Symposium](http://www.ala.org.au/blogs-news/2014-atlas-of-living-australia-science-symposium/) are available in the package vignette, via (in R): `vignette("ALA4R")` and also [as a pdf here](./vignettes/ALA4R.pdf?raw=true).


## Installing ALA4R

### Windows

In R:

```{r}
install.packages("devtools")
library(devtools)
install_github("AtlasOfLivingAustralia/ALA4R")
```

You may see a warning about the `Rtools` package: you don't need to install this. You may also be asked about a location for the `R.cache` directory --- choose whatever you prefer here, ALA4R does not use `R.cache`.

If you wish to use the `data.table` package for potentially faster loading of data matrices (optional), also do:
```{r}
install.packages("data.table")
```


### Linux

First, ensure that `libcurl` is installed on your system --- e.g. on Ubuntu, open a terminal and do:
```BASH
sudo apt-get install libcurl4-openssl-dev
```
or install `libcurl4-openssl-dev` via the Software Centre. Then, fire up R and install the dependencies that we need:
```R
install.packages(c("httr","stringr","plyr","digest","RCurl","jsonlite","assertthat","sp"))
```
If you wish to use the `data.table` package for potentially faster loading of data matrices (optional), also do:
```R
install.packages(c("data.table"))
```
Then the ALA4R package itself:
```R
install.packages("ALA4R",repos="http://rforge.net/")
```


## Using ALA4R
The ALA4R package must be loaded for each new R session:
```R
library(ALA4R)
```

##Customizing ALA4R
Various aspects of the ALA4R package can be customized.

###Caching
ALA4R can cache most results to local files. This means that if the same code is run multiple times, the second and subsequent iterations will be faster. This will also reduce load on the ALA servers.
By default, this caching is session-based, meaning that the local files are stored in a temporary directory that is automatically deleted when the R session is ended. This behaviour can be altered so that caching is permanent, by setting the caching directory to a non-temporary location. For example:
```R
ala_config(cache_directory=file.path("c:","mydata","ala_cache")) ## Windows
```
or for Linux:
```R
ala_config(cache_directory=file.path("~","mydata","ala_cache")) ## Linux
```
Note that this directory must exist (you need to create it yourself).
