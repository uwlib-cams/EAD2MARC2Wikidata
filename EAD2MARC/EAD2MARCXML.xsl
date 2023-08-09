<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:marc="http://www.loc.gov/MARC21/slim"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="marc">
	<!-- The following file can be found on the WWW at http://www.loc.gov/standards/marcxml/xslt/MARC21slimUtils.xsl -->
	<xsl:include href="MARC21slimUtils.xsl"/>
	<xsl:include href="modules/langcodes.xsl"/>
	<xsl:variable name="lc">abcdefghijklmnopqrstuvwxyz</xsl:variable>
	<xsl:variable name="uc">ABCDEFGHIJKLMNOPQRSTUVWXYZ</xsl:variable>
	<xsl:strip-space elements="*"/>
	<!--<xsl:output method="xml" encoding="utf-8" indent="yes" use-character-maps="ALAChars"/>-->
	<xsl:output method="xml" indent="yes"/>	
	<xsl:character-map name="ALAChars">
	<!-- Blasted MS Word smart quotes -->
		<xsl:output-character character="“" string="&quot;"/>
		<xsl:output-character character="”" string="&quot;"/>
		<!-- The jagged apostrophe -->		
		<xsl:output-character character="’" string="&apos;"/>
	</xsl:character-map>
	<xsl:template match="ead">
		<marc:collection xmlns:marc="http://www.loc.gov/MARC21/slim" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
			<marc:record>
				<marc:leader>
					<xsl:text>01125cpcaa22002893i 4500</xsl:text>
				</marc:leader>
				<!--MARC  008-->
				<marc:controlfield tag="008">
					<xsl:text>\\\\\\</xsl:text>
					<!-- This section attempts to extract the date information from the normal attribute in <unitdate> -->
					<xsl:choose>
						<xsl:when test="archdesc/did/unitdate[@type='inclusive']/@normal">
							<xsl:choose>
								<xsl:when test="contains(archdesc/did/unitdate[@type='inclusive']/@normal, '/')">
									<xsl:value-of select="concat('i', substring-before(archdesc/did/unitdate[@type='inclusive']/@normal, '/'), substring-after(archdesc/did/unitdate[@type='inclusive']/@normal, '/'))"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="concat('s', archdesc/did/unitdate[@type='inclusive']/@normal, '\\\\')"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>\9999\\\\</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
					<xsl:text>xx\\\\\\\\\u\\\\\\\\</xsl:text>
					<xsl:choose>
						<xsl:when test="string(archdesc/did/langmaterial/language[1]/@langcode)">
							<xsl:value-of select="normalize-space(archdesc/did/langmaterial/language[1]/@langcode)"/>
						</xsl:when>
						<xsl:otherwise>eng</xsl:otherwise>
					</xsl:choose>
					<xsl:text>\d</xsl:text>
				</marc:controlfield>
				<!-- MARC 040 -->
				<marc:datafield tag="040" ind1="" ind2="">
					<xsl:choose>
						<xsl:when test="not(contains(//eadid/@mainagencycode, '-'))">
							<marc:subfield code="a">
								<xsl:value-of select="translate(substring(//eadid/@mainagencycode, 1), $lc, $uc)"/>
							</marc:subfield>
							<marc:subfield code="b">eng</marc:subfield>
							<marc:subfield code="e">rda</marc:subfield>
							<marc:subfield code="e">dacs</marc:subfield>
							<marc:subfield code="c">
								<xsl:value-of select="translate(substring(//eadid/@mainagencycode, 1), $lc, $uc)"/>
							</marc:subfield>
						</xsl:when>
						<xsl:when test="contains(//eadid/@mainagencycode, '-')">
							<marc:subfield code="a">
								<xsl:value-of select="translate(substring-before(//eadid/@mainagencycode, '-'), $lc, $uc)"/>
							</marc:subfield>
							<marc:subfield code="b">eng</marc:subfield>
							<marc:subfield code="e">rda</marc:subfield>
							<marc:subfield code="e">dacs</marc:subfield>
							<marc:subfield code="c">
								<xsl:value-of select="translate(substring-before(//eadid/@mainagencycode, '-'), $lc, $uc)"/>
							</marc:subfield>
						</xsl:when>
					</xsl:choose>
				</marc:datafield>
				<!-- MARC 041 -->
				<!-- You cannot import MARC 041 directly into OCLC so this template is being ignored. -->
				<!-- This is triggered by the presence of 2 or more <language> elements in archdesc/did/langmaterial. The output is taken from the @langcode attribute -->
				<!--<xsl:if test="string(archdesc/did/langmaterial/language[2])">
					<marc:datafield tag="041" ind1="0" ind2="">
						<xsl:for-each select="archdesc/did/langmaterial/language">
							<!-\- Call this template which always ensures that the language code is correct for the corresponding language -\->
							<xsl:call-template name="langcodes"/>
						</xsl:for-each>
					</marc:datafield>
				</xsl:if>-->
				<!-- MARC 084 -->
				<!--<xsl:if test="string(archdesc/did/unitid[1][@type='resource'])">
					<marc:datafield tag="084" ind1="" ind2="">
						<marc:subfield code="a">UW Resource No.</marc:subfield>
						<marc:subfield code="a"><xsl:value-of select="archdesc/did/unitid[1][@type='resource']"/></marc:subfield>
						<marc:subfield code="2">z</marc:subfield>
						<marc:subfield code="q">wau-ar</marc:subfield>
					</marc:datafield>
				</xsl:if>-->
				<!-- MARC  1xx -->
				<xsl:for-each select="archdesc/did/origination">
					<xsl:if test="string(persname|corpname|famname)">
				<xsl:choose>
					<xsl:when test="string(persname)">
						<xsl:for-each select="persname[1]">
						<marc:datafield tag="100" ind1="1" ind2="">
							<xsl:choose>
								<xsl:when test="contains(., '$')">
									<xsl:variable name="term" select="translate(normalize-space(.), '&#x000D;', '')"/>
									<xsl:call-template name="processSubfields">
										<xsl:with-param name="term" select="$term"/>
										<xsl:with-param name="fullstop" select="'yes'"/>
										<xsl:with-param name="role" select="@role"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<marc:subfield code="a">
										<xsl:value-of select="translate(normalize-space(.), '&#x000D;', '')"/>
										<xsl:if test="not(@role)">
										<xsl:call-template name="fullstop">
											<xsl:with-param name="input" select="normalize-space(.)"/>
										</xsl:call-template>
										</xsl:if>
										<xsl:if test="@role"><xsl:text>,</xsl:text></xsl:if>
									</marc:subfield>
									<xsl:if test="@role">
										<xsl:call-template name="Role">
											<xsl:with-param name="role" select="@role"/>
											<xsl:with-param name="fullstop" select="'yes'"/>
											<xsl:with-param name="input" select="normalize-space(.)"></xsl:with-param>
										</xsl:call-template>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</marc:datafield>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="string(famname)">
						<xsl:for-each select="famname[1]">
						<marc:datafield tag="100" ind1="3" ind2="">
							<xsl:choose>
								<xsl:when test="contains(., '$')">
									<xsl:variable name="term" select="translate(normalize-space(.), '&#x000D;', '')"/>
									<xsl:call-template name="processSubfields">
										<xsl:with-param name="term" select="$term"/>
										<xsl:with-param name="fullstop" select="'yes'"/>
										<xsl:with-param name="role" select="@role"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<marc:subfield code="a">
										<xsl:value-of select="translate(normalize-space(.), '&#x000D;', '')"/>
										<xsl:call-template name="fullstop">
											<xsl:with-param name="input" select="normalize-space(.)"/>
										</xsl:call-template>
									</marc:subfield>
								</xsl:otherwise>
							</xsl:choose>
						</marc:datafield>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="string(corpname)">
						<xsl:for-each select="corpname[1]">
						<xsl:choose>
							
							<xsl:when test="@encodinganalog='111'">
								<marc:datafield tag="111" ind1="2" ind2="">
									<xsl:choose>
										<xsl:when test="contains(., '$')">
											<xsl:variable name="term" select="translate(normalize-space(.), '&#x000D;', '')"/>
											<xsl:call-template name="processSubfields">
												<xsl:with-param name="term" select="$term"/>
												<xsl:with-param name="fullstop" select="'yes'"/>
												<xsl:with-param name="role" select="@role"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a">
												<xsl:value-of select="translate(normalize-space(.), '&#x000D;', '')" />
												<xsl:call-template name="fullstop">
													<xsl:with-param name="input" select="normalize-space(.)"/>
												</xsl:call-template>
											</marc:subfield>
										</xsl:otherwise>
									</xsl:choose>
								</marc:datafield>
								
							</xsl:when>
							<xsl:otherwise>
								<marc:datafield tag="110" ind1="2" ind2="">
									<xsl:choose>
										<xsl:when test="contains(., '$')">
											<xsl:variable name="term" select="translate(normalize-space(.), '&#x000D;', '')"/>
											<xsl:call-template name="processSubfields">
												<xsl:with-param name="term" select="$term"/>
												<xsl:with-param name="fullstop" select="'yes'"/>
												<xsl:with-param name="role" select="@role"/>
											</xsl:call-template>
										</xsl:when>
										<xsl:otherwise>
											<marc:subfield code="a">
												<xsl:value-of select="translate(normalize-space(.), '&#x000D;', '')" />
												<xsl:if test="not(string(@role))">
												<xsl:call-template name="fullstop">
													<xsl:with-param name="input" select="normalize-space(.)"/>
												</xsl:call-template>
												</xsl:if>
												<xsl:if test="string(@role)"><xsl:text>,</xsl:text></xsl:if>
											</marc:subfield>
											<xsl:if test="string(@role)">
												
												<xsl:call-template name="Role">
													<xsl:with-param name="input" select="normalize-space(.)"/>
													<xsl:with-param name="role" select="@role"/>
													<xsl:with-param name="fullstop" select="'yes'"></xsl:with-param>
												</xsl:call-template>
											</xsl:if>
										</xsl:otherwise>
									</xsl:choose>
								</marc:datafield>
							</xsl:otherwise>
							
						</xsl:choose>
						</xsl:for-each>
					</xsl:when>
				</xsl:choose>
					</xsl:if>
				</xsl:for-each>
				<!-- MARC 130 / 245 -->
				<xsl:if test="archdesc/did/unittitle">
					<xsl:if test="archdesc/did/unittitle/@encodinganalog='130'">
						<marc:datafield tag="130" ind1="0" ind2="">
							<marc:subfield code="a">
								<xsl:value-of select="translate(normalize-space(archdesc/did/unittitle[@encodinganalog='130']), '&#x000D;&#x00a0;', '')" />
							</marc:subfield>
						</marc:datafield>
					</xsl:if>
					<marc:datafield tag="245">
						<xsl:choose>
							<xsl:when test="string(archdesc/did/origination/persname) or string(archdesc/did/origination/corpname) or string(archdesc/did/origination/famname) or archdesc/did/unittitle/@encodinganalog='130'">
								<xsl:attribute name="ind1">1</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="ind1">0</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:attribute name="ind2">0</xsl:attribute>
						<marc:subfield code="a">
							<xsl:variable name="unittitle">
								<xsl:value-of select="translate(normalize-space(archdesc/did/unittitle[not(@encodinganalog='130')]), '&#x000D;', '')"/>
								<xsl:text>.</xsl:text>
							</xsl:variable>
							<xsl:value-of select="translate($unittitle, '&#x000D;', '')"/>
						</marc:subfield>
					</marc:datafield>
					<!-- For RDA, map collection dates to MARC 264_0 -->
					<marc:datafield tag="264">
						<xsl:attribute name="ind1"></xsl:attribute>
						<xsl:attribute name="ind2">0</xsl:attribute>
						<marc:subfield code="c">
						<xsl:if test="string(archdesc/did/unitdate[@type='inclusive'])">
								<xsl:variable name="unitdatei">
									<xsl:value-of select="translate(normalize-space(archdesc/did/unitdate[@type='inclusive']), '&#x000D;', '')" />
									<xsl:if test="not(string(archdesc/did/unitdate[@type='bulk']))">
										<xsl:text>.</xsl:text>
									</xsl:if>
								</xsl:variable>
								<xsl:value-of select="translate($unitdatei, '&#x000D;', '')"/>
						</xsl:if>
						<xsl:if test="string(archdesc/did/unitdate[@type='bulk'])">
								<xsl:variable name="unitdateb">
									<xsl:value-of select="concat(' (bulk ', translate(normalize-space(archdesc/did/unitdate[@type='bulk']), '&#x000D;', ''), ').')" />
								</xsl:variable>
								<xsl:value-of select="translate($unitdateb, '&#x000D;', '')"/>
						</xsl:if>
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 254 / 255 / 256 -->
				<xsl:if test="archdesc/did/materialspec/@encodinganalog">
					<marc:datafield tag="{substring(archdesc/did/materialspec/@encodinganalog, 1, 3)}" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/did/materialspec), '&#x000D;', '')"/>
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 300 -->
					<xsl:for-each select="archdesc/did/physdesc[not(@audience='internal')]">
						<marc:datafield tag="300" ind1="" ind2="">
									<marc:subfield code="a">
										<xsl:value-of select="normalize-space(extent[1])"/>
										<xsl:if test="string(physfacet) and not(string(extent[2]))">
											<xsl:text> :</xsl:text>
										</xsl:if>
									</marc:subfield>
							<xsl:if test="string(extent[2])">
								<xsl:variable name="extent2" select="translate(normalize-space(extent[2]), '&#x000D;', '')"/>
								<xsl:choose>
									<xsl:when test="starts-with($extent2, '(')">
										<marc:subfield code="a">
											<xsl:value-of select="normalize-space($extent2)" />
											<xsl:if test="string(physfacet)">
												<xsl:text> :</xsl:text>
											</xsl:if>
										</marc:subfield>
									</xsl:when>
									<xsl:otherwise>
										<marc:subfield code="a">
											<xsl:value-of select="concat(' (', normalize-space($extent2), ')')" />
											<xsl:if test="string(physfacet)">
												<xsl:text> :</xsl:text>
											</xsl:if>
										</marc:subfield>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:if>
							<xsl:if test="not(string(extent[2])) and not(string(physfacet)) and not(string(dimensions))">
								<xsl:call-template name="fullstop">
									<xsl:with-param name="input" select="normalize-space(extent[1])"/>
								</xsl:call-template>
							</xsl:if>
							<xsl:if test="string(physfacet)">
								<marc:subfield code="b">
									<xsl:value-of select="translate(normalize-space(physfacet), '&#x000D;', '')" />
									<xsl:if test="string(dimensions)">
										<xsl:text> ;</xsl:text>
									</xsl:if>
								</marc:subfield>
							</xsl:if>
							<xsl:if test="string(dimensions)">
								<marc:subfield code="c">
									<xsl:value-of select="translate(normalize-space(dimensions), '&#x000D;', '')" />
								</marc:subfield>
							</xsl:if>
						</marc:datafield>
					</xsl:for-each>
				<!-- MARC 336/337/338 -->
				<xsl:for-each select="archdesc/did/physdesc[1]/extent[1]">
					<xsl:choose>
						<xsl:when test="contains(., 'film')">
							<marc:datafield tag="336" ind1="" ind2="">
								<marc:subfield code="a">two-dimensional moving image</marc:subfield>
								<marc:subfield code="b">tdi</marc:subfield>
								<marc:subfield code="2">rdacontent</marc:subfield>
							</marc:datafield>
							<marc:datafield tag="337" ind1="" ind2="">
								<marc:subfield code="a">projected</marc:subfield>
								<marc:subfield code="b">g</marc:subfield>
								<marc:subfield code="2">rdamedia</marc:subfield>
							</marc:datafield>
							<marc:datafield tag="338" ind1="" ind2="">
								<marc:subfield code="a">film reel</marc:subfield>
								<marc:subfield code="b">mr</marc:subfield>
								<marc:subfield code="2">rdacarrier</marc:subfield>
							</marc:datafield>
						</xsl:when>
						<xsl:when test="contains(., 'photo') or contains(., 'negative')">
							<marc:datafield tag="336" ind1="" ind2="">
								<marc:subfield code="a">still image</marc:subfield>
								<marc:subfield code="b">tdi</marc:subfield>
								<marc:subfield code="2">rdacontent</marc:subfield>
							</marc:datafield>
							<marc:datafield tag="337" ind1="" ind2="">
								<marc:subfield code="a">unmediated</marc:subfield>
								<marc:subfield code="b">n</marc:subfield>
								<marc:subfield code="2">rdamedia</marc:subfield>
							</marc:datafield>
							<marc:datafield tag="338" ind1="" ind2="">
								<marc:subfield code="a">sheet</marc:subfield>
								<marc:subfield code="b">nb</marc:subfield>
								<marc:subfield code="2">rdacarrier</marc:subfield>
							</marc:datafield>
						</xsl:when>
						<xsl:otherwise>
							<marc:datafield tag="336" ind1="" ind2="">
								<marc:subfield code="a">text</marc:subfield>
								<marc:subfield code="b">txt</marc:subfield>
								<marc:subfield code="2">rdacontent</marc:subfield>
							</marc:datafield>
							<marc:datafield tag="337" ind1="" ind2="">
								<marc:subfield code="a">unmediated</marc:subfield>
								<marc:subfield code="b">n</marc:subfield>
								<marc:subfield code="2">rdamedia</marc:subfield>
							</marc:datafield>
							<marc:datafield tag="338" ind1="" ind2="">
								<marc:subfield code="a">sheet</marc:subfield>
								<marc:subfield code="b">nb</marc:subfield>
								<marc:subfield code="2">rdacarrier</marc:subfield>
							</marc:datafield>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
				<!-- MARC 340/538 -->
				<xsl:if test="archdesc/phystech/@encodinganalog and string(archdesc/phystech[not(@audience='internal')])">
					<!-- Since <phystech> can map to either MARC 340 or 538, the correct mapping must be specified in the encodinganalog attribute. -->
					<marc:datafield tag="{normalize-space(archdesc/phystech/@encodinganalog)}"	ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/phystech), '&#x000D;', '')"/>
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 545 -->
				<xsl:if test="string(archdesc/bioghist[not(@audience='internal')])">
					<marc:datafield tag="545">
						<xsl:choose>
							<xsl:when test="starts-with(archdesc/bioghist/@encodinganalog, '5450') or contains(archdesc/bioghist/head, 'Biographical') or string(archdesc/did/origination/persname)">
								<xsl:attribute name="ind1">0</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="ind1">1</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
						<xsl:attribute name="ind2"></xsl:attribute>
						<marc:subfield code="a">
							<xsl:for-each select="archdesc/bioghist">
							<xsl:apply-templates/>
							</xsl:for-each>
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 520 -->
				<xsl:if test="string(archdesc/scopecontent[not(@audience='internal')])">
					<marc:datafield tag="520" ind1="2" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/scopecontent), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 351 -->
				<xsl:if test="string(archdesc/arrangement[not(@audience='internal')])">
					<marc:datafield tag="351" ind1="" ind2="">
						<marc:subfield code="a">
							<!--<xsl:value-of select="translate(normalize-space(archdesc/arrangement), '&#x000D;', '')" />-->
							<xsl:for-each select="archdesc/arrangement">
							<xsl:for-each select="child::*"><xsl:text> </xsl:text><xsl:apply-templates/></xsl:for-each>
							</xsl:for-each>
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				
				<!-- MARC 506 -->
				<xsl:if test="string(archdesc/accessrestrict[not(@audience='internal')])">
					<marc:datafield tag="506" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/accessrestrict[not(@audience='internal')]), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 540 -->
				<xsl:if test="string(archdesc/userestrict[not(@audience='internal')])">
					<marc:datafield tag="540" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/userestrict), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 541 -->
				<xsl:if test="string(archdesc/acqinfo[not(@audience='internal')])">
					<marc:datafield tag="541" ind1="" ind2="">
						<xsl:variable name="acqNormal" select="translate(normalize-space(archdesc/acqinfo), '&#x000D;', '')"/>
						
						<xsl:choose>
							<xsl:when test="starts-with(archdesc/acqinfo, 'Donor:') or starts-with(archdesc/acqinfo, 'Donated by:')">
								<marc:subfield code="c">
									<xsl:value-of select="concat(substring-before($acqNormal, ':'), ':')" />
								</marc:subfield>
								<marc:subfield code="a">
									<xsl:value-of select="substring-after($acqNormal, ': ')" />
								</marc:subfield>
							</xsl:when>
							<xsl:otherwise>
								<marc:subfield code="a">
									<xsl:value-of select="translate(normalize-space(archdesc/acqinfo), '&#x000D;', '')" />
								</marc:subfield>		
							</xsl:otherwise>
						</xsl:choose>
						
					</marc:datafield>
				</xsl:if>
				<!-- MARC 524 -->
				<xsl:if test="string(archdesc/prefercite[not(@audience='internal')])">
					<marc:datafield tag="524" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/prefercite), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 546 -->
				<xsl:if test="string(archdesc/did/langmaterial/language[1])">
					<marc:datafield tag="546" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:choose>
								<!-- Can only test first word "collection" unless possible word wrap is stipped out -->
								<xsl:when test="starts-with(archdesc/did/langmaterial, 'Collection')">
									<xsl:value-of select="translate(normalize-space(archdesc/did/langmaterial), '&#x000D;', '')" />			
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="translate(normalize-space(concat('Collection materials are in ', archdesc/did/langmaterial)), '&#x000D;', '')" />
								</xsl:otherwise>
							</xsl:choose>
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 555 -->
				<!--<xsl:if test="string(archdesc/otherfindaid[not(@audience='internal')])">
					<marc:datafield tag="555" ind1="0" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/otherfindaid), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>-->
				<!-- MARC 561 -->
				<xsl:if test="string(archdesc/custodhist[not(@audience='internal')])">
					<marc:datafield tag="561" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/custodhist), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 584 -->
				<xsl:if test="string(archdesc/accruals[not(@audience='internal')])">
					<marc:datafield tag="584" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/accruals), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 535 -->
				<xsl:if test="string(archdesc/originalsloc[not(@audience='internal')])">
					<marc:datafield tag="535" ind1="1" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/originalsloc), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 530 -->
				<xsl:if test="string(archdesc/altformavail[not(@audience='internal')])">
					<marc:datafield tag="530" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(archdesc/altformavail), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 544 -->
				<xsl:for-each select="archdesc/separatedmaterial[not(@audience='internal')]">
					<xsl:if test="string(.)">
						<marc:datafield tag="544" ind1="" ind2="">
							<marc:subfield code="n">
								<xsl:value-of select="translate(normalize-space(archdesc/separatedmaterial), '&#x000D;', '')" />
							</marc:subfield>
						</marc:datafield>
					</xsl:if>	
				</xsl:for-each>
				<xsl:if test="string(archdesc/relatedmaterial[not(@audience='internal')])">
					<xsl:for-each select="archdesc/relatedmaterial">
					<marc:datafield tag="544" ind1="1" ind2="">
						<marc:subfield code="n">
							<xsl:for-each select="p">
							<xsl:value-of select="translate(normalize-space(.), '&#x000D;', '')" />
								<xsl:if test="not(position()=last())">
									<xsl:text>; </xsl:text>
								</xsl:if>
							</xsl:for-each>
						</marc:subfield>
					</marc:datafield>
					</xsl:for-each>
				</xsl:if>
				<!-- UW only -->
				<xsl:if test="string(archdesc/processinfo/processinfo[@type='reloc']) and //eadid/@mainagencycode='wau-ar'">
					<marc:datafield tag="544" ind1="" ind2="">
						<marc:subfield code="n">
							<xsl:value-of select="normalize-space(archdesc/processinfo/processinfo[@type='reloc'])" />
						</marc:subfield>
					</marc:datafield>
				</xsl:if>
				<!-- MARC 500 -->
				<xsl:if test="string(archdesc/odd[not(@audience='internal')][not(@type='hist')][@encodinganalog='500'])">
					<xsl:for-each select="archdesc/odd">
					<marc:datafield tag="500" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(.), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
					</xsl:for-each>
				</xsl:if>
				<xsl:if test="string(archdesc/note[not(@audience='internal')][@encodinganalog='500'])">
					<xsl:for-each select="archdesc/note">
					<marc:datafield tag="500" ind1="" ind2="">
						<marc:subfield code="a">
							<xsl:value-of select="translate(normalize-space(.), '&#x000D;', '')" />
						</marc:subfield>
					</marc:datafield>
					</xsl:for-each>
				</xsl:if>
				<!-- CONTROLACCESS -->
				<!-- Starting July 2019, only copy Marc 710 i.e. corpname elements to Marc output such
				as Labor Archives of Washington -->	
				<xsl:for-each select="archdesc//controlaccess/corpname[not(@altrender='nodisplay')][not(@audience='internal')]">
					<xsl:if test="string(self::*)">
						<xsl:variable name="term" select="translate(normalize-space(.), '&#x000D;', '')"/>
<!-- Starting July 2019, assume everything is Marc 710 no matter whether it has an @encodinganalog or not -->							
								<marc:datafield tag="710" ind1="2" ind2="">
									<xsl:call-template name="processSubfields">
										<xsl:with-param name="term" select="$term"/>
										<xsl:with-param name="fullstop" select="'yes'"/>
									</xsl:call-template>
								</marc:datafield>
					</xsl:if>
				</xsl:for-each>
				<!-- MARC 856 -->
				<xsl:if test="//eadid/@identifier">
					<marc:datafield tag="856" ind1="4" ind2="2">
						<marc:subfield code="u">
							<xsl:value-of select="concat('http://archiveswest.orbiscascade.org/ark:/', normalize-space(eadheader/eadid/@identifier))" />
						</marc:subfield>
						<marc:subfield code="z">Connect to the online finding aid for this collection</marc:subfield>
					</marc:datafield>
				</xsl:if>
			</marc:record>
		</marc:collection>
	</xsl:template>
	<xsl:template name="encodedsubfields">
		<xsl:param name="input" />
		<xsl:param name="search-string" />
		<xsl:param name="subcode"/>
		<xsl:param name="fullstop"/>
		<xsl:param name="role"/>
		<xsl:choose>
			<xsl:when test="$search-string and contains($input,$search-string)">
				<marc:subfield code="{$subcode}">
					<xsl:value-of select="substring-before($input,$search-string)" />
				</marc:subfield>
				<xsl:call-template name="encodedsubfields">
					<xsl:with-param name="input" select="substring(substring-after($input,$search-string), 2)" />
					<xsl:with-param name="search-string" select="$search-string" />
					<xsl:with-param name="subcode" select="substring(substring-after($input, '$'), 1, 1)"/>
					<xsl:with-param name="fullstop" select="$fullstop"/>
					<xsl:with-param name="role" select="$role"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<marc:subfield code="{$subcode}">
					<xsl:value-of select="$input" />
					<xsl:if test="$fullstop='yes' and not(string($role))">
						<xsl:call-template name="fullstop">
							<xsl:with-param name="input" select="$input"/>
						</xsl:call-template>
					</xsl:if>
					<xsl:if test="string($role)">
						<xsl:text>,</xsl:text>
					</xsl:if>
				</marc:subfield>
				<xsl:if test="string($role)">
					<xsl:call-template name="Role">
						<xsl:with-param name="role" select="$role"/>
						<xsl:with-param name="input" select="$input"/>
						<xsl:with-param name="fullstop" select="$fullstop"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="processSubfields">
		<xsl:param name="term"/>
		<xsl:param name="fullstop"/>
		<xsl:param name="role"/>
		<xsl:choose>
			<xsl:when test="contains($term, '$')">
				<xsl:if test="not(starts-with($term, '$'))">
					<marc:subfield code="a">
						<xsl:value-of select="substring-before($term, '$')" />
					</marc:subfield>
				</xsl:if>
				<xsl:call-template name="encodedsubfields">
					<xsl:with-param name="input" select="substring(substring-after($term, '$'), 2)" />
					<xsl:with-param name="search-string" select="'$'" />
					<xsl:with-param name="subcode" select="substring(substring-after($term, '$'), 1, 1)"/>
					<xsl:with-param name="fullstop" select="$fullstop"/>
					<xsl:with-param name="role" select="$role"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<marc:subfield code="a">
					<xsl:value-of select="$term" />
					<xsl:if test="$fullstop='yes' and not(string($role))">
						
						<xsl:call-template name="fullstop">
							<xsl:with-param name="input" select="$term"/>
						</xsl:call-template>
					</xsl:if>
				</marc:subfield>
				<xsl:if test="string($role)">
					<xsl:call-template name="Role">
						<xsl:with-param name="input" select="$term"/>
						<xsl:with-param name="fullstop" select="$fullstop"/>
						<xsl:with-param name="role" select="$role"/>
					</xsl:call-template>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="fullstop">
		<xsl:param name="input"/>
		<xsl:variable name="fullstop" select="normalize-space($input)" />
		<xsl:variable name="chars">.-?!])</xsl:variable>
		<xsl:if test="contains($chars, substring($fullstop, string-length($fullstop), 1)) = false()">
			<xsl:text>.</xsl:text>
		</xsl:if>
	</xsl:template>
	<xsl:template name="Role">
		<xsl:param name="input"/>
		<xsl:param name="role"/>
		<xsl:param name="fullstop"/>
		<marc:subfield code="e">
			<xsl:value-of select="$role"/>
			<xsl:if test="$fullstop='yes'">
				<xsl:call-template name="fullstop">
					<xsl:with-param name="input" select="$input"/>
				</xsl:call-template>
			</xsl:if>
		</marc:subfield>
	</xsl:template>
	<xsl:template match="item[ancestor::arrangement]">
		<xsl:apply-templates/><xsl:if test="not(position()=last())"><xsl:text> -- </xsl:text></xsl:if>
	</xsl:template>
	<xsl:template match="p">
		<xsl:apply-templates/><xsl:text> </xsl:text>
	</xsl:template>
	<xsl:template match="text()">
		<xsl:value-of select="translate(normalize-space(.), '&#x000D;', '')"/>
	</xsl:template>
</xsl:stylesheet>