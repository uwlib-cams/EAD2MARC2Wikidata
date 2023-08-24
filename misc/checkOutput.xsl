<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim" version="2.0">
    <xsl:variable name="lookupTable" select="document('table1.xml')"/>
    <xsl:variable name="sourceMarc" select="document('LaborArchivesMARCRecordsBatch.xml')"/>
    <xsl:key name="lookup" match="row" use="oclc"/>
    <xsl:template match="/">
        <root>
            <QuantityCheck>
                <recordsInSourceMarc>
                    <xsl:value-of select="count($sourceMarc/marc:collection/marc:record)"/>
                </recordsInSourceMarc>
                <rowsInLookupTable>
                    <xsl:value-of select="count($lookupTable/root/row)"/>
                </rowsInLookupTable>
                <recordsInMarcOuput>
                    <xsl:value-of select="count(marc:collection/marc:record)"/>
                </recordsInMarcOuput>
            </QuantityCheck>
            <OutputRecordIntegrityChecks>
                <xsl:apply-templates select="marc:collection"/>
            </OutputRecordIntegrityChecks>
            <marcVsLookup>
                <xsl:apply-templates select="marc:collection/marc:record" mode="general"/>
            </marcVsLookup>
            <multiple856>
                <xsl:apply-templates select="marc:collection/marc:record" mode="multiple856"/>
            </multiple856>
        </root>
    </xsl:template>
    <xsl:template match="marc:collection">
        <xsl:for-each select="marc:record">
            <xsl:if test="not(marc:datafield[@tag = '758'])">
                <no758Field>
                    <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                </no758Field>
            </xsl:if>
            <xsl:if test="count(marc:datafield[@tag = '758']) > 1">
                <moreThanOne758Field>
                    <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                </moreThanOne758Field>
            </xsl:if>
            <xsl:for-each select="marc:datafield[@tag = '758']">
                <xsl:if test="not(./marc:subfield[@code = 'a']/text())">
                    <_758aNotExtracted>
                        <xsl:value-of select="../marc:controlfield[@tag = '001']"/>
                    </_758aNotExtracted>
                </xsl:if>
                <xsl:if test="contains(./marc:subfield[@code = 'a'], 'ERROR')">
                    <_758aError>
                        <xsl:value-of select="../marc:controlfield[@tag = '001']"/>
                    </_758aError>
                </xsl:if>
                <xsl:if test="not(contains(./marc:subfield[@code = '0'], 'Q'))">
                    <_758-0-missingQnumber>
                        <xsl:value-of select="../marc:controlfield[@tag = '001']"/>
                    </_758-0-missingQnumber>
                </xsl:if>
                <xsl:if test="contains(./marc:subfield[@code = '0'], 'ERROR')">
                    <_758-0-ERROR>
                        <xsl:value-of select="../marc:controlfield[@tag = '001']"/>
                    </_758-0-ERROR>
                </xsl:if>
                <xsl:if test="not(contains(./marc:subfield[@code = '0'], 'Q'))">
                    <_758-1-IdentifierMissing>
                        <xsl:value-of select="../marc:controlfield[@tag = '001']"/>
                    </_758-1-IdentifierMissing>
                </xsl:if>
            </xsl:for-each>
            <xsl:if test="not(marc:datafield[@tag = '856'])">
                <no856Field>
                    <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                </no856Field>
            </xsl:if>
            <xsl:for-each select="marc:datafield[@tag = '856']">
                <xsl:if test="not(./marc:subfield[@code = 'u']/text())">
                    <_856LackingSubfield-u>
                        <xsl:value-of select="../marc:controlfield[@tag = '001']"/>
                    </_856LackingSubfield-u>
                </xsl:if>
                <xsl:if test="contains(./marc:subfield[@code = 'u'], 'ERROR')">
                    <_856uError>
                        <xsl:value-of select="../marc:controlfield[@tag = '001']"/>
                    </_856uError>
                </xsl:if>
            </xsl:for-each>
        </xsl:for-each>


        <!--<xsl:for-each select="marc:collection/marc:record">
            <xsl:if test="count(marc:datafield[@tag = '856']) &gt; 1">
                <record>
                    <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                </record>
            </xsl:if>
        </xsl:for-each>-->
    </xsl:template>
    <xsl:template match="marc:record" mode="general">
        <xsl:choose>
            <xsl:when
                test="not(contains(marc:controlfield[@tag = '001'], 'ocn') or contains(marc:controlfield[@tag = '001'], 'ocm') or contains(marc:controlfield[@tag = '001'], 'on'))">
                <xsl:if test="not(key('lookup', marc:controlfield[@tag = '001'], $lookupTable))">
                    <oops>
                        <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                    </oops>
                </xsl:if>
            </xsl:when>
            <xsl:when test="contains(marc:controlfield[@tag = '001'], 'ocn')">
                <xsl:if
                    test="not(key('lookup', substring-after(marc:controlfield[@tag = '001'], 'ocn'), $lookupTable))">
                    <oclcNoNotInLookup>
                        <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                    </oclcNoNotInLookup>
                </xsl:if>
            </xsl:when>
            <xsl:when test="contains(marc:controlfield[@tag = '001'], 'ocm')">
                <xsl:if
                    test="not(key('lookup', substring-after(marc:controlfield[@tag = '001'], 'ocm'), $lookupTable))">
                    <oclcNoNotInLookup>
                        <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                    </oclcNoNotInLookup>
                </xsl:if>
            </xsl:when>
            <xsl:when test="contains(marc:controlfield[@tag = '001'], 'on')">
                <xsl:if
                    test="not(key('lookup', substring-after(marc:controlfield[@tag = '001'], 'on'), $lookupTable))">
                    <oclcNoNotInLookup>
                        <xsl:value-of select="marc:controlfield[@tag = '001']"/>
                    </oclcNoNotInLookup>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>MARC vs. Lookup info not available for record with OCLC number </xsl:text>
                <xsl:value-of select="marc:controlfield[@tag = '001']"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template match="marc:record" mode="multiple856">
        <xsl:if test="count(marc:datafield[@tag = '856']) > 1">
            <xsl:value-of select="marc:controlfield[@tag = '001']"/>
            <xsl:text>   </xsl:text>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
<!--
old > 1 856
new no 758

orig script
retain all 856 in xsl 1
add corected 856
probably xsl#2
remove broken links and dupes (both 758 field dupes and 856) -->
