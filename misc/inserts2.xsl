<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:key name="lookup" match="row" use="oclc"/>
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="lookupTable" select="document('table1.xml')"/>
    <xsl:template match="marc:datafield[@tag = '856'][position() = 1]">
        <xsl:call-template name="add758_856"/>
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template name="add758_856">
        <marc:datafield tag="758" ind1=" " ind2=" ">
            <marc:subfield code="i">Wikidata item: </marc:subfield>
            <marc:subfield code="a">
                <xsl:choose>
                    <xsl:when test="key('lookup', ../marc:controlfield[@tag = '001'], $lookupTable)">
                        <xsl:value-of select="key('lookup', ../marc:controlfield[@tag = '001'], $lookupTable)/label"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocn'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocn'), $lookupTable)/label"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocm'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocm'), $lookupTable)/label"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'on'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'on'), $lookupTable)/label"/>
                    </xsl:when>
                    <xsl:otherwise>MARC FIELD 758 $a ERROR</xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
            </marc:subfield>
            <marc:subfield code="2">wikidata </marc:subfield>
            <marc:subfield code="4">http://www.wikidata.org/entity/P2888 </marc:subfield>
            <marc:subfield code="0">
                <xsl:text>(wikidata)</xsl:text>
                <xsl:choose>
                    <xsl:when test="key('lookup', ../marc:controlfield[@tag = '001'], $lookupTable)">
                        <xsl:value-of select="key('lookup', ../marc:controlfield[@tag = '001'], $lookupTable)/qid"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocn'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocn'), $lookupTable)/qid"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocm'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocm'), $lookupTable)/qid"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'on'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'on'), $lookupTable)/qid"/>
                    </xsl:when>
                    <xsl:otherwise>MARC FIELD 758 $0 ERROR</xsl:otherwise>
                </xsl:choose>
                <xsl:text> </xsl:text>
            </marc:subfield>
            <marc:subfield code="1">
                <xsl:text>http://www.wikidata.org/entity/</xsl:text>
                <xsl:choose>
                    <xsl:when test="key('lookup', ../marc:controlfield[@tag = '001'], $lookupTable)">
                        <xsl:value-of select="key('lookup', ../marc:controlfield[@tag = '001'], $lookupTable)/qid"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocn'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocn'), $lookupTable)/qid"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocm'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocm'), $lookupTable)/qid"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'on'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'on'), $lookupTable)/qid"/>
                    </xsl:when>
                    <xsl:otherwise>MARC FIELD 758 $1 ERROR</xsl:otherwise>
                </xsl:choose>
            </marc:subfield>
        </marc:datafield>
        <marc:datafield tag="856" ind1="4" ind2="2">
            <marc:subfield code="u">
                <xsl:choose>
                    <xsl:when test="key('lookup', ../marc:controlfield[@tag = '001'], $lookupTable)">
                        <xsl:value-of select="key('lookup', ../marc:controlfield[@tag = '001'], $lookupTable)/aw"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocn'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocn'), $lookupTable)/aw"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocm'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'ocm'), $lookupTable)/aw"/>
                    </xsl:when>
                    <xsl:when test="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'on'), $lookupTable)">
                        <xsl:value-of select="key('lookup', substring-after(../marc:controlfield[@tag = '001'],'on'), $lookupTable)/aw"/>
                    </xsl:when>
                    <xsl:otherwise>MARC FIELD 856 $u ERROR</xsl:otherwise>
                </xsl:choose>
            </marc:subfield>
            <marc:subfield code="z">Connect to the online finding aid for this
                collection.</marc:subfield>
        </marc:datafield>
    </xsl:template>
</xsl:stylesheet>
