# Bulletin of Online Emendations to Papyri (BOEP)

## Setup

### The folders

*  archive (recent boeps as well as the latest boep)
  * lastest.html 
*  epidoc (soft link to copy of example-p5-xslt-8.16, get it from here  https://sourceforge.net/projects/epidoc/files/Example%20Stylesheets/)
*  idp.data (soft link to a copy of the idp.data repository,  https://github.com/papyri/idp.data)
*  web (soft link to a web server folder with http access) 

### The xslt files

* htm-tpl-apparatus.xsl (copy of epidoc/htm-tpl-apparatus.xsl, unaltered, just to make sure that it includes the local version of tpl-apparatus.xsl)
* helper.xsl
* select.xsl (xslt script that keeps only new entries)
* start-boep.xsl (xslt script that collects all emendations from DDB, orginally copied from epidoc start-edition.xsl)
* tpl-apparatus.xsl (modified version of epidoc/tpl-apparatus.xsl) 

### The html output files

* ListeDerKorrekturen_komplett.html (becomes archive/latest.html
* ListeDerKorrekturen.html 

### Helpful scripts

* scan (to be called directly from the folder where it resides) 

## Workflow

On L’s MacMini…
```
cd ~/projects/boep
./scan
```

then view results
```
open ListeDerKorrekturen.html
```

and afterthorough review finally save latest run
````
cp ListeDerKorrekturen_komplett.html archive/latest.html
```

