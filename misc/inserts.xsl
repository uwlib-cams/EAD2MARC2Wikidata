<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim" version="3.0">
    <xsl:mode on-no-match="shallow-copy"/>
    <xsl:key name="lookup" match="row" use="oclc"/>
    <xsl:output indent="yes"/>
    <xsl:template match="marc:datafield[@tag='040']">
        <marc:datafield tag="024" ind1="7" ind2=" ">
            <marc:subfield code="a">
                <xsl:value-of select="key('lookup',../marc:controlfield[@tag='001'],document('table.xml'))/qid"/>
            </marc:subfield>
            <marc:subfield code="2">wikidata</marc:subfield>
        </marc:datafield>
        <marc:datafield tag="024" ind1="7" ind2=" ">
            <marc:subfield code="a">
                <xsl:value-of select="key('lookup',../marc:controlfield[@tag='001'],document('table.xml'))/qid"/>
            </marc:subfield>
            <marc:subfield code="2">uri</marc:subfield>
        </marc:datafield>
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="marc:datafield[@tag='856']">
        <marc:datafield tag="856" ind1="1" ind2="7">
            <marc:subfield code="u">
                <xsl:value-of select="key('lookup',../marc:controlfield[@tag='001'],document('table.xml'))/aw"/>
            </marc:subfield>
            <marc:subfield code="z">Connect to the online finding aid for this collection.</marc:subfield>
        </marc:datafield>
    </xsl:template>
</xsl:stylesheet>