<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:key name="lookup" match="row" use="oclc"/>
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="lookupTable" select="document('table2.xml')"/>
    <xsl:template match="marc:datafield[@tag='856']">
        <marc:datafield tag="758" ind1=" " ind2=" ">
            <marc:subfield code="i">Wikidata item: </marc:subfield>
            <marc:subfield code="a">
                <xsl:value-of select="key('lookup',../marc:controlfield[@tag='001'],$lookupTable)/label"/>
                <xsl:text> </xsl:text>
            </marc:subfield>
            <marc:subfield code="2">wikidata </marc:subfield>
            <marc:subfield code="4">http://www.wikidata.org/entity/P2888 </marc:subfield>
            <marc:subfield code="0">
                <xsl:text>(wikidata)</xsl:text>
                <xsl:value-of select="key('lookup',../marc:controlfield[@tag='001'],$lookupTable)/qid"/>
                <xsl:text> </xsl:text>
            </marc:subfield>
            <marc:subfield code="1">
                <xsl:text>http://www.wikidata.org/entity/</xsl:text>
                <xsl:value-of select="key('lookup',../marc:controlfield[@tag='001'],$lookupTable)/qid"/>
            </marc:subfield>
        </marc:datafield>
        <marc:datafield tag="856" ind1="4" ind2="2">
            <marc:subfield code="u">
                <xsl:value-of select="key('lookup',../marc:controlfield[@tag='001'],$lookupTable)/aw"/>
            </marc:subfield>
            <marc:subfield code="z">Connect to the online finding aid for this collection.</marc:subfield>
        </marc:datafield>
    </xsl:template>
</xsl:stylesheet>