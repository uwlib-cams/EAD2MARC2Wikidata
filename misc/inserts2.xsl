<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:marc="http://www.loc.gov/MARC21/slim" version="3.0">
    <!-- Primary XML Input document is a collection of MARCXML records. -->
    <!-- mode below is XSLT 3.0 identity transform equivalent. -->
    <xsl:mode on-no-match="shallow-copy"/>
    <!-- Key below will be used to match a value in the XML input document with a value in $lookupTable (see variable definition below). -->
    <xsl:key name="lookup" match="row" use="oclc"/>
    <xsl:output indent="yes"/>
    <xsl:strip-space elements="*"/>
    <!-- The lookup table is stored as a document in a variable. The lookup table requires specific structures:
        (1) A root element;
        (2) Child elements of the root called row;
        (3) Each row should have row/label, row/oclc, row/qid, row/aw;
            (a) row/label. Name/title/label. Extracted from MARC 245;
            (b) row/oclc. OCLC record number;
            (c) row/qid. Wikidata identifier;
            (d) row/aw. Archives West URL.
    -->
    <!-- Current instance of this XSLT document inputs a second XML document 'table1.xml' containing the "lookupTable' described above;
         This is done in the variable below. -->
    <xsl:variable name="lookupTable" select="document('table1.xml')"/>
    <!-- Template below aspires to insert a 758 field and an 856 just before the first 856 in the original MARC record.
         This assumes, perhaps incorrectly, a numerical order of MARC fields can be maintained when MARC 856 always follows MARC 758. -->
    <xsl:template match="marc:datafield[@tag = '856'][position() = 1]">
        <xsl:call-template name="add758_856"/>
        <xsl:copy-of select="."/>
    </xsl:template>
    <xsl:template name="add758_856">
        <!-- This template may duplicate an already-existing MARC field in the original MARC record.
             no effort was made to eliminate duplicates. -->
        <marc:datafield tag="758" ind1=" " ind2=" ">
            <marc:subfield code="i">Wikidata item: </marc:subfield>
            <marc:subfield code="a">
                <xsl:choose>
                    <!-- conditions below account for oclc numbers both without a prefix and prefixed with any of the following character combintions: ocn, ocm, on;
                         if conditions are not met, an error message will output to the result document. -->
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
                    <!-- conditions below account for oclc numbers both without a prefix and prefixed with any of the following character combintions: ocn, ocm, on;
                         if conditions are not met, an error message will output to the result document. -->
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
                    <!-- conditions below account for oclc numbers both without a prefix and prefixed with any of the following character combintions: ocn, ocm, on;
                         if conditions are not met, an error message will output to the result document. -->
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
                    <!-- conditions below account for oclc numbers both without a prefix and prefixed with any of the following character combintions: ocn, ocm, on;
                         if conditions are not met, an error message will output to the result document. -->
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
