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

All results will be stored in that cache directory and will be used from one session to the next. They won’t be re-downloaded from the server unless the user specifically deletes those files or changes the caching setting to “refresh”.

If you change the cache_directory to a permanent location, you may wish to add something like this to your .Rprofile file, so that it happens automatically each time the ALA4R package is loaded:
```R
setHook(packageEvent("ALA4R", "attach"), 
function(...) ala_config(cache_directory=file.path("~","mydata","ala_cache")))
```
Caching can also be turned off entirely by:
```R
ala_config(caching="off")
```
or set to “refresh”, meaning that the cached results will re-downloaded from the ALA servers and the cache updated. (This will happen for as long as caching is set to “refresh” — so you may wish to switch back to normal “on” caching behaviour once you have updated your cache with the data you are working on).

###User-agent string
Each request to the ALA servers is accompanied by a “user-agent” string that identifies the software making the request. This is a standard behaviour used by web browsers as well. The user-agent identifies the user requests to the ALA, helping the ALA to adapt and enhance the services that it provides. By default, the ALA4R user-agent string is set to “ALA4R” plus the ALA4R version number, R version, and operating system (e.g. “ALA4R 0.16 (R version 3.0.2 (2013-09-25)/x86_64-pc-linux-gnu)”).

*NO* personal identification information is sent. You can see all configuration settings, including the the user-agent string that is being used, with the command:
```R
ala_config()
```

###Debugging
If things aren’t working as expected, more detail (particularly about web requests and caching behaviour) can be obtained by setting the verbose configuration option:
```R
ala_config(verbose=TRUE)
```

##Examples
We’ll use the plyr package throughout these examples, so load that now:
```R
library(plyr) 
```
###Example 1: Name searching and taxonomic trees
You may need to install these packages first using `R install.packages(c("ape","phytools"))`:
```R
library(ape)
library(phytools)
```
We want to look at the taxonomic tree of penguins, but we don’t know what the correct scientific name is, so let’s search for it:
```R
sx=search_fulltext("penguins")
(sx$data[,c("name","rank","score","commonName")])
```
```
##                                    name       rank     score
## 1                          SPHENISCIDAE     family 7.796e+00
## 2                       Eudyptula minor    species 6.895e-01
## 3                   Eudyptes chrysocome    species 2.998e-09
## 4       Eudyptes pachyrhynchus robustus subspecies 2.596e-09
## 5                        Pteria penguin    species 1.273e-09
## 6                Eudyptes pachyrhynchus    species 8.494e-10
## 7                 Eudyptes chrysolophus    species 8.494e-10
## 8  Eudyptes pachyrhynchus pachyrhynchus subspecies 8.488e-10
## 9                     Eudyptes sclateri    species 6.372e-10
## 10              Aptenodytes patagonicus    species 2.641e-10
##                                                                                                                                                                                                                                                                                                                                                     commonName
## 1                                                                                                                                                                                                                                                                                                                                                     Penguins
## 2   Blue Penguin,  Fairy Penguin, Fairy Penguin, Little Penguin, Little Penguin In The Manly Point Area (being The Area On And Near The Shoreline From Cannae Point Generally Northward To The Point Near The Intersection Of Stuart Street And Oyama Cove Avenue, And Extending 100 Metres Offshore From That Shoreline), Little Penguin, Little Blue Penguin
## 3                                                                                                                                                                                                                                                            Crested Penguin, Jackass Penguin, Tufted Penguin, Rockhopper Penguin, Southern Rockhopper Penguin
## 4                                                                                                                                                                                                                                                                                              Snares Crested Penguin,  Snares Islands Penguin, Snares Penguin
## 5                                                                                                                                                                                                                                                                                                         Black Banded Winged Pearl Shell, Penguin Wing Oyster
## 6                                                                                                                                                                                                                                                                                                                 Fiordland Crested Penguin, Fiordland Penguin
## 7                                                                                                                                                                                                                                                                                                                              Macaroni Penguin, Royal Penguin
## 8                                                                                                                                                                                                                                                                                                                 Fiordland Crested Penguin, Fiordland Penguin
## 9                                                                                                                                                                                                                                                                                                                   Big-crested Penguin, Erect-crested Penguin
## 10                                                                                                                                                                                                                                                                                                                                                King Penguin
```
