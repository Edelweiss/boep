<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:hgv="HGV"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fm="http://www.filemaker.com/fmpxmlresult"
    xmlns:date="http://exslt.org/dates-and-times"
    xmlns:common="http://exslt.org/common"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="#all" version="2.0">

    <xsl:template name="wordBefore">
        <xsl:param name="fix" />
        <xsl:variable name="wordBefore"><xsl:sequence select="hgv:getWordBefore($fix)" /></xsl:variable>
        <xsl:for-each select="$wordBefore/node()">
            <xsl:choose>
                <xsl:when test="not(name(.))">
                    <xsl:value-of select="." />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="wordAfter">
        <xsl:param name="fix" />
        <xsl:variable name="wordAfter"><xsl:sequence select="hgv:getWordAfter(.)" /></xsl:variable>
        <xsl:for-each select="$wordAfter/node()">
            <xsl:choose>
                <xsl:when test="not(name(.))">
                    <xsl:value-of select="." />
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates select="."/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:function name="hgv:getWordBefore">
        <xsl:param name="fix"/>
        <xsl:for-each-group select="$fix/preceding-sibling::node()" group-starting-with="t:lb">
            <xsl:if test="position() = last()">
                
                <xsl:variable name="relevantItems">
                    <xsl:sequence select="hgv:toTheBlank(reverse(current-group()), 1, 2, 'before')" />
                </xsl:variable>
                
                <xsl:sequence select="reverse($relevantItems/node())" />
                
            </xsl:if>
        </xsl:for-each-group>
    </xsl:function>
    
    <xsl:function name="hgv:getWordAfter">
        <xsl:param name="fix"/>
        
        <xsl:variable name="relevantItems">
            <xsl:sequence select="hgv:toTheBlank($fix/following-sibling::node(), 1, 2, 'after')" />
        </xsl:variable>
        
        <xsl:sequence select="$relevantItems/node()" />
        
    </xsl:function>
    
    <xsl:function name="hgv:toTheBlank">
        <xsl:param name="group" />
        <xsl:param name="index" />
        <xsl:param name="blankCount" />
        <xsl:param name="position" />
        
        <xsl:variable name="currentItem" select="$group[$index]"/>
        
        <xsl:choose>
            <xsl:when test="not($currentItem)" />
            <xsl:when test="name($currentItem) = 'lb'" />
            <xsl:otherwise>
                
                <xsl:variable name="blankCountNew" select="hgv:if(not(name($currentItem)) and contains($currentItem, ' '), $blankCount - string-length(replace($currentItem, '[^ ]', '')), $blankCount)"/>
                
                <xsl:choose>
                    <xsl:when test="($currentItem instance of text()) and ($blankCountNew &lt;  1)">
                        <xsl:choose>
                            <xsl:when test="$position = 'before'">
                                <xsl:sequence select="replace($currentItem, '^.* ([^ ]*)$', '$1')"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:sequence select="replace($currentItem, '^([^ ]*) .*$', '$1')"/>
                            </xsl:otherwise>
                        </xsl:choose>
                        
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:sequence select="$currentItem" />
                        <xsl:sequence select="hgv:toTheBlank($group, $index + 1, $blankCountNew, $position)" />
                    </xsl:otherwise>
                </xsl:choose>
                
            </xsl:otherwise>
        </xsl:choose>
        
    </xsl:function>
    
    <xsl:function name="hgv:if">
        <xsl:param name="test" />
        <xsl:param name="option1" />
        <xsl:param name="option2" />
        <xsl:choose>
            <xsl:when test="$test">
                <xsl:value-of select="$option1"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="$option2"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
</xsl:stylesheet>