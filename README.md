# Bulletin of Online Emendations to Papyri (BOEP)

https://papy.zaw.uni-heidelberg.de/boep/
http://archiv.ub.uni-heidelberg.de/propylaeumdok/view/collections/c-19.type.html

## Setup

### The folders

*  archive (recent boeps as well as the latest boep)
  * lastest.html 
*  epidoc (soft link to copy of example-p5-xslt-8.16, get it from here  https://sourceforge.net/projects/epidoc/files/Example%20Stylesheets/)
*  idp.data (soft link to a copy of the idp.data repository, https://github.com/papyri/idp.data), keep it up-to-date
*  web (soft link to a web server folder with http access, e.g. Papy SDS project browsable under https://papy.zaw.uni-heidelberg.de/boep/) 

### The xslt files

* htm-tpl-apparatus.xsl (copy of epidoc/htm-tpl-apparatus.xsl, unaltered, just to make sure that it includes the local version of tpl-apparatus.xsl)
* helper.xsl
* select.xsl (xslt script that keeps only new entries)
* start-boep.xsl (xslt script that collects all emendations from DDB, orginally copied from epidoc start-edition.xsl)
* tpl-apparatus.xsl (modified version of epidoc/tpl-apparatus.xsl) 

### The html output files

* ListeDerKorrekturen_komplett.html (becomes archive/latest.html)
* ListeDerKorrekturen.html (the actual boep result file of the current run)

### Helpful scripts

* scan (to be called directly from the folder where it resides) 
  * calls BOEP template in xslt script star-boep.xsl to collect all emendations
  * calls xslt script select.xsl 
  * copies results (komplett and selected) to archive folder

## Workflow

On L’s MacMini…

…update the git repositories the `idp.data` softlink points to or set them to a desired commit version
```
update_git_repositories
```

…run the scripts for ddb and dclp
```
cd ~/projects/boep
./scan
./scan_dclp
```

…then review the results
```
open ListeDerKorrekturen.html
open ListeDerKorrekturen_dclp.html
```
(view in browser: [aquila/boep](https://papy.zaw.uni-heidelberg.de/boep/))

…and after thorough review finally save latest run
```
cp ListeDerKorrekturen_komplett.html archive/latest.html
cp ListeDerKorrekturen_komplett_dclp.html archive_dclp/latest.html
```

