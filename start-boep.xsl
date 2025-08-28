<?xml version="1.0" encoding="UTF-8"?>
<!-- copied from example-p5-xslt/start-edition.xsl -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:t="http://www.tei-c.org/ns/1.0"
   xmlns:dcterms="http://purl.org/dc/terms/"
   xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   exclude-result-prefixes="t" version="2.0">
   <xsl:output indent="yes" method="xml" encoding="UTF-8"/>

   <xsl:include href="epidoc/global-varsandparams.xsl"/>

   <!-- html related stylesheets, these may import tei{element} stylesheets if relevant eg. htm-teigap and teigap -->
   <xsl:include href="epidoc/htm-teiab.xsl"/>
   <xsl:include href="epidoc/htm-teiaddanddel.xsl"/>
   <xsl:include href="epidoc/htm-teiapp.xsl"/>
   <xsl:include href="epidoc/htm-teidiv.xsl"/>
   <xsl:include href="epidoc/htm-teidivedition.xsl"/>
   <xsl:include href="epidoc/htm-teiforeign.xsl"/>
   <xsl:include href="epidoc/htm-teifigure.xsl"/>
   <xsl:include href="epidoc/htm-teig.xsl"/>
   <xsl:include href="epidoc/htm-teigap.xsl"/>
   <xsl:include href="epidoc/htm-teihead.xsl"/>
   <xsl:include href="epidoc/htm-teihi.xsl"/>
   <xsl:include href="epidoc/htm-teilb.xsl"/>
   <xsl:include href="epidoc/htm-teilgandl.xsl"/>
   <xsl:include href="epidoc/htm-teilistanditem.xsl"/>
   <xsl:include href="epidoc/htm-teilistbiblandbibl.xsl"/>
   <xsl:include href="epidoc/htm-teimilestone.xsl"/>
   <xsl:include href="epidoc/htm-teinote.xsl"/>
   <xsl:include href="epidoc/htm-teinum.xsl"/>
   <xsl:include href="epidoc/htm-teip.xsl"/>
   <xsl:include href="epidoc/htm-teiseg.xsl"/>
   <xsl:include href="epidoc/htm-teispace.xsl"/>
   <xsl:include href="epidoc/htm-teisupplied.xsl"/>
   <xsl:include href="epidoc/htm-teiterm.xsl"/>
   <xsl:include href="epidoc/htm-teiref.xsl"/>

   <!-- tei stylesheets that are also used by start-txt -->
   <xsl:include href="epidoc/teiabbrandexpan.xsl"/>
   <xsl:include href="epidoc/teicertainty.xsl"/>
   <xsl:include href="epidoc/teichoice.xsl"/>
   <xsl:include href="epidoc/teihandshift.xsl"/>
   <xsl:include href="epidoc/teiheader.xsl"/>
   <xsl:include href="epidoc/teimilestone.xsl"/>
   <xsl:include href="epidoc/teiorig.xsl"/>
   <xsl:include href="epidoc/teiorigandreg.xsl"/>
   <xsl:include href="epidoc/teiq.xsl"/>
   <xsl:include href="epidoc/teisicandcorr.xsl"/>
   <xsl:include href="epidoc/teispace.xsl"/>
   <xsl:include href="epidoc/teisupplied.xsl"/>
   <xsl:include href="epidoc/teisurplus.xsl"/>
   <xsl:include href="epidoc/teiunclear.xsl"/>

   <!-- html related stylesheets for named templates -->
   <xsl:include href="epidoc/htm-tpl-cssandscripts.xsl"/>
   <xsl:include href="htm-tpl-apparatus.xsl"/>
   <xsl:include href="epidoc/htm-tpl-lang.xsl"/>
   <xsl:include href="epidoc/htm-tpl-metadata.xsl"/>
   <xsl:include href="epidoc/htm-tpl-license.xsl"/>
   <xsl:include href="epidoc/htm-tpl-sqbrackets.xsl"/>
   
   <!-- named templates for localized layout/structure (aka "metadata") -->
   <xsl:include href="epidoc/htm-tpl-structure.xsl"/>
   <xsl:include href="epidoc/htm-tpl-struct-hgv.xsl"/>
   <xsl:include href="epidoc/htm-tpl-struct-inslib.xsl"/>
   <xsl:include href="epidoc/htm-tpl-struct-rib.xsl"/>
   <xsl:include href="epidoc/htm-tpl-struct-iospe.xsl"/>
   <xsl:include href="epidoc/htm-tpl-struct-edh.xsl"/>

   <!-- global named templates with no html, also used by start-txt -->
   <xsl:include href="epidoc/tpl-certlow.xsl"/>
   <xsl:include href="epidoc/tpl-text.xsl"/>

   <!--
      edn-structure = default

      call BOEP template on P.Mich.9
      java net.sf.saxon.Transform -o:/Library/WebServer/Documents/tmp/ListeDerKorrekturen_P.Mich.html -it:BOEP -xsl:/Users/Admin/epidoc/trunk/example-p5-xslt/start-boep.xsl subfolder=p.mich/p.mich.9 apparatus-style=ddbdp
      java net.sf.saxon.Transform -o:/Library/WebServer/Documents/tmp/ListeDerKorrekturen_BGU16.html -it:BOEP -xsl:/Users/Admin/epidoc/trunk/example-p5-xslt/start-boep.xsl subfolder=bgu/bgu.16 apparatus-style=ddbdp

      Transform P.Mich.9 directory
      java net.sf.saxon.Transform -o:/Users/Admin/tmp/boep -s:/Users/Admin/idp.data/boep/DDB_EpiDoc_XML/p.mich/p.mich.9 -xsl:/Users/Admin/epidoc/trunk/example-p5-xslt/start-boep.xsl apparatus-style=ddbdp
      java net.sf.saxon.Transform -o:/Users/Admin/tmp/boep -s:/Users/Admin/idp.data/boep/DDB_EpiDoc_XML/bgu/bgu.16 -xsl:/Users/Admin/epidoc/trunk/example-p5-xslt/start-boep.xsl apparatus-style=ddbdp
      
      17. P. Heilporn (new fragment) (via PN) : [ἐν τρι]σὶ prev. ed.
      
      Generate new BEOP (taken vom scan script)
      java -Xms512m -Xmx1536m net.sf.saxon.Transform -o:ListeDerKorrekturen_komplett.html -it:BOEP -xsl:/Users/Admin/epidoc/trunk/example-p5-xslt/start-boep.xsl apparatus-style=ddbdp leiden-style=ddbdp
      for bgu 4 only
      java -Xms512m -Xmx1536m net.sf.saxon.Transform -o:ListeDerKorrekturen_komplett.html -it:BOEP -xsl:/Users/Admin/epidoc/trunk/example-p5-xslt/start-boep.xsl apparatus-style=ddbdp leiden-style=ddbdp subfolder=bgu/bgu.4
      
      Altes git repo zur Initialisierung bei neuem Algorithmus (Achtung: Backslashes rausnehmen [wegen XML-Kommentar]):
      git checkout "`git rev-list master  -n 1 -\-first-parent -\-before=2022-11-02`"
      (zurück mit: git checkout master)

   -->
   
   <xsl:include href="helper.xsl"/>
   
   <xsl:param name="idpData" select="'idp.data'"/>
   <xsl:param name="textFolder" select="'DDB_EpiDoc_XML'"/> <!-- DDB_EpiDoc_XML or DCLP -->
   <xsl:param name="subfolder"/> <!-- e.g bgu for DDB or 1 for DCLP -->

   <xsl:variable name="COLLECTION" select="doc(concat($idpData, '/RDF/collection.rdf'))"/><!-- maps ddb hybrid (bgu) to nice citation (BGU) -->

   <xsl:template name="BOEP">
      <xsl:variable name="project" select="lower-case(replace($textFolder, '_EpiDoc_XML', ''))"/>
      <html>
         <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
            <title>
               <xsl:text>BOEP</xsl:text>

               <xsl:value-of select="concat(' ', $project)"/>

               <xsl:if test="$subfolder">
                  <xsl:value-of select="concat(' ', $subfolder)"/>
               </xsl:if>
            </title>
            <style>
              body { font-family: "Lucida Grande", "Cardo", "Arial Unicode MS","Galilee Unicode Gk", "New Athena Unicode", "Athena Unicode", 
              "Palatino Linotype", "Titus Cyberbit Basic", "Vusillus Old Face", "Alphabetum", "Galatia SIL", 
              "Code 2000", "GentiumAlt", "Gentium", "Minion Pro", "GeorgiaGreek", "Vusillus Old Face Italic", 
              "Everson Mono", "Aristarcoj", "Porson", "Legendum", "Aisa Unicode", "Hindsight Unicode", "Caslon", 
              "Verdana", "Tahoma"; }
              table {
                border-collapse: collapse;
              }
              td.ddb {
                width: 8em;
              }
              td.position {
                padding: 0 1em 0 1em;
                text-align: right;
              }
              td.apparatus {
                padding: 0 0 0 1em;
                border-style: solid;
                border-width: 0 0 0 1px;
              }
              .resp { font-style: italic; }
              .date { font-style: italic; font-size: x-small; }
              img.beehive_link {
                margin-left: 4px;
                width: 14px;
                height: auto;
              }
              img.tm_logo {
                margin-left: 4px;
                width: 16px;
                height: auto;
              }
            </style>
         </head>
         <body>
            <h1>Bulletin of Online Emendations to Papyri (BOEP)</h1>
            <p class="date" style="position: absolute; top: 1em; right: 1em;"><xsl:value-of select="current-dateTime()"/></p>

            <xsl:variable name="sourceFiles" select="concat($idpData, '/', $textFolder, if ($subfolder) then concat('/', $subfolder) else '', '?select=*.xml;recurse=yes')"/>            
            <xsl:message select="substring-before($sourceFiles, '?')"/>
            
            <table>
            <xsl:for-each select="collection($sourceFiles)//t:ab/t:app[@type='editorial']/t:lem[starts-with(@resp,'PN')]/..">
               <xsl:variable name="ddb" select="string(/t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type='ddb-hybrid'])" />
               <xsl:variable name="tm" select="/t:TEI/t:teiHeader/t:fileDesc/t:publicationStmt/t:idno[@type='TM']" />
               <xsl:variable name="url" select="concat('http://papyri.info/ddbdp/', $ddb)" />
               <xsl:variable name="title">
                  <xsl:choose>
                     <xsl:when test="$textFolder = 'DCLP'">
                        <xsl:value-of select="$tm"/>
                     </xsl:when>
                     <xsl:otherwise>
                        <xsl:variable name="series" select="tokenize($ddb, ';')[1]" />
                        <xsl:variable name="volume" select="tokenize($ddb, ';')[2]" />
                        <xsl:variable name="number" select="tokenize($ddb, ';')[3]" />
                        <xsl:variable name="seriesCanon" select="string($COLLECTION//rdf:Description[ends-with(@rdf:about, concat('ddbdp/', $series))]/dcterms:bibliographicCitation)" />
                        <xsl:value-of select="$seriesCanon"/>
                        <xsl:if test="string($volume)">
                           <xsl:text> </xsl:text>
                           <xsl:value-of select="$volume"/>
                        </xsl:if>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="$number"/>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:variable>

               <xsl:message select="concat($ddb, ' / ', $tm)"/>

               <xsl:variable name="line" select="preceding-sibling::*[name() = 'lb'][position() = 1]/@n" />
               <xsl:variable name="resp" select="substring-after(t:lem/@resp, 'PN ')" />
               <xsl:variable name="lem" select="t:lem" />
               <xsl:variable name="rdg" select="t:rdg" />
               <xsl:variable name="lineTo" select="descendant::t:lb[position() = last()]/@n" />
               <xsl:variable name="apparatus"> <!-- cl: copied from htm-tpl-structure.xsl -->
                  <xsl:call-template name="ddbdp-app"><!-- Found in tpl-apparatus.xsl, take off point for TEI:app[type='editorial'] -->
                     <xsl:with-param name="apptype" select="'apped'"/>
                  </xsl:call-template>
               </xsl:variable>
               <xsl:variable name="apparatusPosition" select="normalize-space($apparatus/text()[1])"/>
               <xsl:variable name="apparatusText" select="$apparatus/text()[1]/following-sibling::*"/>
               <xsl:variable name="id" select="concat($tm, '|', $ddb, '|', translate(normalize-space($resp), ' 𝈪𐅵𐅷𐅸', '_Llw8'), '|', replace(normalize-space($apparatus), ' ', '_'))"/>

               <xsl:message><xsl:text>____ </xsl:text><xsl:value-of select="$url"/><xsl:value-of select="$title"/><xsl:text> (</xsl:text><xsl:value-of select="$url"/><xsl:text>) ____</xsl:text></xsl:message>
               <tr id="{$id}" title="{$title}" data-tm="{$tm}" data-ddb="{$ddb}" data-resp="{$resp}" data-apparatus="{$apparatus}">
                  <!-- link to PN -->
                  <td class="ddb">
                     <span>
                        <a href="{$url}" title="TM {$tm}">
                           <xsl:value-of select="$title" />
                        </a>
                     </span>
                  </td>
                  <td class="position">
                     <xsl:text> </xsl:text>
                     <span>
                        <xsl:value-of select="replace($apparatusPosition, '^(.+)\.$', '$1')" />
                     </span>
                  </td>

                  <!-- Main text output -->
                  <td class="apparatus">
                     <xsl:apply-templates select="$apparatusText" mode="sqbrackets"/><!-- Moded templates found in htm-tpl-sqbrackets.xsl -->
                     <!-- resp, author -->
                     <xsl:if test="string($resp)">
                        <xsl:text>, </xsl:text>
                        <span class="resp"><xsl:value-of select="replace($resp, '(\((digital image|online image|from image|image|from photograph|photograph|from digital photo|on photo|photo)\))', '(from photo)')"/></span>
                     </xsl:if>
                  </td>

               </tr>
         <!--<xsl:apply-templates select="/" />-->
         <!--<xsl:apply-templates select="/t:TEI/t:text[1]/t:body[1]/t:div/t:ab/t:app[@type='editorial']" />-->
         <!--<xsl:call-template name="ddbdp-app"><!-\- Found in tpl-apparatus.xsl, take off point for TEI:app[type='editorial'] -\->
            <xsl:with-param name="apptype" select="'apped'"/>
         </xsl:call-template>-->
      </xsl:for-each>
            </table>

            <p class="date"><xsl:value-of select="current-dateTime()"/></p>
         </body>
      </html>
   </xsl:template>

</xsl:stylesheet>
