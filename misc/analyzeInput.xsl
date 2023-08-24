<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim" version="2.0">
    <xsl:variable name="lookupTable" select="document('table1.xml')"/>
    <xsl:key name="lookup" match="row" use="oclc"/>
    <xsl:template match="/">
        <root>
            <xsl:apply-templates select="marc:collection"/>
        </root>
    </xsl:template>
    <xsl:template match="marc:collection">
        <noOfRecordsInMarc>
            <xsl:value-of select="count(marc:record)"/>
        </noOfRecordsInMarc>
        <noOfRecordsInLookup>
            <xsl:value-of select="count($lookupTable/root/row)"/>
        </noOfRecordsInLookup>
        <xsl:for-each select="marc:record">
            <xsl:choose>
                <xsl:when test="key('lookup', substring-after(marc:controlfield[@tag = '001'] ,'ocn'), $lookupTable)">
                    <oclcInBothLocations>
                        <xsl:value-of
                            select="key('lookup', substring-after(marc:controlfield[@tag = '001'], 'ocn'), $lookupTable)/oclc"
                        />
                    </oclcInBothLocations>
                </xsl:when>
                <xsl:when test="key('lookup', substring-after(marc:controlfield[@tag = '001'] ,'on'), $lookupTable)">
                    <oclcInBothLocations>
                        <xsl:value-of
                            select="key('lookup', substring-after(marc:controlfield[@tag = '001'], 'on'), $lookupTable)/oclc"
                        />
                    </oclcInBothLocations>
                </xsl:when>
                <xsl:when test="key('lookup', substring-after(marc:controlfield[@tag = '001'] ,'ocm'), $lookupTable)">
                    <oclcInBothLocations>
                        <xsl:value-of
                            select="key('lookup', substring-after(marc:controlfield[@tag = '001'], 'ocm'), $lookupTable)/oclc"
                        />
                    </oclcInBothLocations>
                </xsl:when>
                <xsl:when test="not(key('lookup', marc:controlfield[@tag = '001'], $lookupTable))">
                    <MarcOclcNotInLookup>
                        <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                    </MarcOclcNotInLookup>
                </xsl:when>
                <xsl:otherwise>
                    <text>Unaccounted-for MARC record</text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
