<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:hgv="HGV"
  xmlns:bp="BP"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:fm="http://www.filemaker.com/fmpxmlresult"
  xmlns:date="http://exslt.org/dates-and-times"
  xmlns:common="http://exslt.org/common"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  xmlns="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="#all" version="2.0">

  <xsl:output indent="yes" method="xml" encoding="UTF-8"/>
  
  <xsl:param name="project" select="'ddb'"/>
  
  <xsl:variable name="latest">
    <xsl:sequence select="document(concat('archive', if($project = 'dclp')then('_dclp')else(''), '/latest.html'))//tr"/>
  </xsl:variable>

<!--

java net.sf.saxon.Transform -o:ListeDerKorrekturen.html -s:ListeDerKorrekturen_komplett.html -xsl:select.xsl
java net.sf.saxon.Transform -o:ListeDerKorrekturen_dclp.html -s:ListeDerKorrekturen_komplett_dclp.html -xsl:select.xsl

-->

  <xsl:template match="tr">

    <!--xsl:variable name="href" select="string(td/span/a/@href)" />
    <xsl:variable name="text" select="text()" /-->
    <xsl:variable name="id" select="string(@id)" />

    <!--xsl:variable name="found" select="$latest//a[@href = $href]/../../..[text() = $text]" /-->
    <xsl:variable name="found" select="$latest//tr[@id = $id]" />

    <xsl:message select="'------------------'" />
    <!--xsl:message select="string(span/a/@href)" /-->
    <xsl:message select="$id" />

    <!--xsl:message><xsl:copy-of  select="$found" /></xsl:message-->

    <xsl:if test="not($found)">
      <xsl:copy>
        <xsl:apply-templates select="@*|node()" />
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>