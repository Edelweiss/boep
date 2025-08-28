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
  
  <xsl:template name="TEST">
    <xsl:variable name="bgu_1_295"><xsl:text>41054|bgu;1;295|N._Gonis_(image)|v.1._  ̣  ̣  ̣  ̣  ̣  ̣  ̣_Ἀ[πόλ]λ̣ω_ποταμίτου_[_-ca.?-_]_→_Παμοῦν̣_υἱọῦ̣_[Ἀπο]λ̣λ̣ῶ_ποταμίτου_χρ(υσίου)_[νο(μισματίου)_α_π(αρὰ)_κ(εράτια)_ζ_𐅵_δ_']_[_-ca.?-_]</xsl:text></xsl:variable>
    <!--xsl:message select="$latest//tr[starts-with(@id, $bgu_1_295)]"></xsl:message>
    <xsl:message select="$latest//tr[contains(@id, 'bgu;1;295')]"></xsl:message-->
    
    <!--xsl:message select="$latest"></xsl:message-->
    <xsl:message select="."></xsl:message>
  </xsl:template>

  <xsl:template match="tr">

    <!--xsl:variable name="href" select="string(td/span/a/@href)" />
    <xsl:variable name="text" select="text()" /-->
    <xsl:variable name="id" select="string(@id)" />
    <xsl:variable name="tm" select="string(@data-tm)" />
    <xsl:variable name="ddb" select="string(@data-ddb)" />
    <xsl:variable name="resp" select="string(@data-resp)" />
    <xsl:variable name="apparatus" select="string(@data-apparatus)" />
    <xsl:message select="'id ', $id"/>

    <!--xsl:variable name="found" select="$latest//a[@href = $href]/../../..[text() = $text]" /-->
    <xsl:variable name="found" select="$latest//tr[@id = $id]" />
    <xsl:variable name="foundSimil" select="$latest//tr[@data-apparatus = $apparatus][@data-tm != $tm or @data-ddb != $ddb or @resp != $resp]" />
    <xsl:variable name="foundPeers" select="$latest//tr[@data-tm = $tm or @data-ddb = $ddb]" />

    <xsl:message select="'------------------'" />
    <!--xsl:message select="string(span/a/@href)" /-->
    <!--xsl:message select="$id" /-->

    <!--xsl:message><xsl:copy-of  select="$found" /></xsl:message-->

    <xsl:if test="not($found)">
      <xsl:copy>
        <xsl:apply-templates select="@*|node()" />
        <td>
          <xsl:if test="$foundSimil">
            <xsl:attribute name="title" select="concat('similar entry (probably with slightly different meta data) already exists - ', string-join($foundSimil))"/>
            <xsl:text>Simil</xsl:text>
          </xsl:if>
        </td>
        <td>
          <xsl:if test="$foundPeers">
            <xsl:attribute name="title" select="concat('peers ', $ddb, ' / TM', $tm)"/>
            <xsl:text>*</xsl:text>
          </xsl:if>
        </td>
        <td title="TM">
          <a href="https://www.trismegistos.org/text/{$tm}"><xsl:value-of select="$tm"/><img class="tm_logo" src="https://www.trismegistos.org/img/tm_logo.png" /></a>
        </td>
        <td title="Beehive">
          <a href="https://beehive.zaw.uni-heidelberg.de/tm/{$tm}"><xsl:value-of select="'Beehive'"/><img class="beehive_link" src="https://beehive.zaw.uni-heidelberg.de/images/frontend/punkt.png"/></a>
        </td>
      </xsl:copy>
    </xsl:if>
  </xsl:template>

  <xsl:template match="@* | node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>