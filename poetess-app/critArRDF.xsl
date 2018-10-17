<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcterms="http://purl.org/dc/terms/"
    xmlns:nines="http://www.nines.org/schema#" xmlns:pa="http://www.poetessarchive.org/schema#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#"
    xmlns:role="http://www.loc.gov/loc.terms/relators/" xmlns:collex="http://www.collex.org/schema#">

    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <!-- these variables need to be changed depending on what you are transforming -->
    <xsl:variable name="baseURL">http://www.poetessarchive.org</xsl:variable>
    <xsl:variable name="collectionURL">critarchive</xsl:variable>
    <xsl:variable name="collectionDate">1828</xsl:variable>

    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="list">
        <xsl:for-each select="item">
            <xsl:apply-templates select="document(@code)/tei:TEI">
                <xsl:with-param name="xpathFilename" select="@code"/>
            </xsl:apply-templates>
        </xsl:for-each>
    </xsl:template>

    <xsl:template match="tei:TEI">
        <xsl:param name="xpathFilename"/>
        <xsl:variable name="Filename">
            <xsl:value-of select="substring-before($xpathFilename, '.xml')"/>
        </xsl:variable>
        <xsl:variable name="id" select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno"/>
        <xsl:result-document href="../RDF/{$Filename}.rdf">
            <rdf:RDF>
                <xsl:element name="pa:critArchive">
                    <xsl:attribute name="rdf:about">
                        <xsl:value-of
                            select="concat('http://www.poetessarchive.org/', $collectionURL, '/', $id)"
                        />
                    </xsl:attribute>
                    <xsl:apply-templates select="tei:teiHeader"/>
                    <xsl:apply-templates select="tei:text/tei:body"/>
                </xsl:element>
            </rdf:RDF>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="tei:teiHeader">
        
        <!--federation-->
        <xsl:choose>
            <xsl:when test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:date">
                <xsl:choose>
                    <xsl:when
                        test="number(substring(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:date/@when, 1, 4)) &gt;= 1785">
                        <collex:federation>NINES</collex:federation>
                        <collex:federation>18thConnect</collex:federation>
                    </xsl:when>
                    <xsl:otherwise>
                        <collex:federation>18thConnect</collex:federation>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when
                        test="number(substring(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date/@when, 1, 4)) &gt;= 1785">
                        <collex:federation>NINES</collex:federation>
                        <collex:federation>18thConnect</collex:federation>
                    </xsl:when>
                    <xsl:otherwise>
                        <collex:federation>18thConnect</collex:federation>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>

        <!-- contributing project -->
        <collex:archive>poetess</collex:archive>

        <!-- object information -->
        <xsl:choose>
            <xsl:when test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic">
                <dc:title>
                    <xsl:value-of
                        select="normalize-space(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:title[1])"/>
                    <xsl:if
                        test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:title[2]">
                        <xsl:text> </xsl:text>
                        <xsl:value-of
                            select="normalize-space(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:title[2])"
                        />
                    </xsl:if>
                </dc:title>
                <dc:source>
                    <xsl:value-of
                        select="normalize-space(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title[1])"/>
                    <xsl:if
                        test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title[2]">
                        <xsl:text> </xsl:text>
                        <xsl:value-of
                            select="normalize-space(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title[2])"
                        />
                    </xsl:if>
                </dc:source>
            </xsl:when>
            <xsl:otherwise>
                <dc:title>
                    <xsl:value-of
                        select="normalize-space(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title[1])"/>
                    <xsl:if
                        test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title[2]">
                        <xsl:text> </xsl:text>
                        <xsl:value-of
                            select="normalize-space(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title[2])"
                        />
                    </xsl:if>
                </dc:title>
            </xsl:otherwise>
        </xsl:choose>

        <!-- creator -->
        <xsl:if
            test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:author[@type = 'writer']">
            <role:AUT>
                <xsl:value-of
                    select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:author[@type = 'writer']/tei:name"
                />
            </role:AUT>
        </xsl:if>
        <xsl:if
            test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:author != tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:author[@type='writer']">
            <role:AUT>
                <xsl:value-of
                    select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:author/tei:name"
                />
            </role:AUT>
        </xsl:if>
        <xsl:if test="tei:fileDesc/tei:soureDesc/tei:biblStruct/tei:monogr/tei:editor">
            <role:EDT>
                <xsl:value-of
                    select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:editor/tei:name"
                />
            </role:EDT>
        </xsl:if>
      <xsl:if test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:publisher[1]">
                <role:PBL>
                    <xsl:value-of
                        select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:publisher[1]"
                    />
                </role:PBL></xsl:if>
        <xsl:if test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:publisher[2]">
            <role:PBL>
                <xsl:value-of
                    select="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:publisher[2]"
                />
            </role:PBL></xsl:if>  
        
        <!-- format -->
        <xsl:choose>
            <xsl:when test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:title[@level='j']">
                <dc:type>Periodical</dc:type>
            </xsl:when>
            <xsl:otherwise>
                <dc:type>Codex</dc:type>
            </xsl:otherwise>
        </xsl:choose>
        
        <!-- keywords in dc:subject -->
        <xsl:apply-templates select="tei:profileDesc/tei:textClass/tei:keywords[@scheme='#lcsh']/tei:list/tei:item" mode="kw"/>
        
        <!--discipline -->
        <collex:discipline>Literature</collex:discipline>
        
        <!--genre -->
        <xsl:apply-templates select="tei:profileDesc/tei:textClass" mode="genre"/>
       
        <!--Collex questions-->
        <collex:freeculture>True</collex:freeculture>
        <collex:ocr>False</collex:ocr>
        <collex:fulltext>True</collex:fulltext>
        <dc:language>English</dc:language>
        
        <!--Date -->
        <xsl:choose>
            <xsl:when test="tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:date">
                <dc:date><xsl:value-of select="substring(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic/tei:date/@when, 1, 4)"/></dc:date>
            </xsl:when>
            <xsl:otherwise>
                <dc:date><xsl:value-of select="substring(tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:monogr/tei:imprint/tei:date/@when, 1, 4)"/></dc:date>
            </xsl:otherwise>
        </xsl:choose>
        
        <!--Links-->
        <collex:thumbnail rdf:resource="{$baseURL}/PA-thumbnail-2.gif"/>
        <collex:source_xml rdf:resource="{$baseURL}/{$collectionURL}/XML/{tei:fileDesc/tei:publicationStmt/tei:idno}.xml"/>
        <collex:text rdf:resource="{$baseURL}/{$collectionURL}/text/{tei:fileDesc/tei:publicationStmt/tei:idno}.txt"/>
        <rdfs:seeAlso rdf:resource="{$baseURL}/{$collectionURL}/HTML/{tei:fileDesc/tei:publicationStmt/tei:idno}.html"/>
    </xsl:template>
    
    <!-- if a thing has parts -->
    <xsl:template match="tei:body">
        <xsl:apply-templates select="tei:div[@type='collection']"/>
    </xsl:template>
    
    <!-- getting tags -->
    <xsl:template match="tei:textClass" mode="genre">
    <xsl:variable name="genreID">
        <xsl:for-each select="tokenize(tei:catRef[@scheme = '#g']/@target, ' ')">
            <tag><xsl:value-of select="substring-after(., '#')"/></tag>
        </xsl:for-each>
    </xsl:variable>
        <xsl:if test="$genreID/tag[1]">
            <collex:genre><xsl:value-of select="parent::tei:profileDesc/preceding-sibling::tei:encodingDesc/tei:classDecl/tei:taxonomy[@xml:id = 'g']/tei:category[@xml:id=$genreID/tag[1]]/tei:catDesc"/></collex:genre>
        </xsl:if>
        <xsl:if test="$genreID/tag[2]">
            <collex:genre><xsl:value-of select="parent::tei:profileDesc/preceding-sibling::tei:encodingDesc/tei:classDecl/tei:taxonomy[@xml:id = 'g']/tei:category[@xml:id=$genreID/tag[2]]/tei:catDesc"/></collex:genre>
        </xsl:if>
        <xsl:if test="$genreID/tag[3]">
            <collex:genre><xsl:value-of select="parent::tei:profileDesc/preceding-sibling::tei:encodingDesc/tei:classDecl/tei:taxonomy[@xml:id = 'g']/tei:category[@xml:id=$genreID/tag[3]]/tei:catDesc"/></collex:genre>
        </xsl:if>
        <xsl:if test="$genreID/tag[4]">
            <collex:genre><xsl:value-of select="parent::tei:profileDesc/preceding-sibling::tei:encodingDesc/tei:classDecl/tei:taxonomy[@xml:id = 'g']/tei:category[@xml:id=$genreID/tag[4]]/tei:catDesc"/></collex:genre>
        </xsl:if>
        <xsl:if test="$genreID/tag[5]">
            <collex:genre><xsl:value-of select="parent::tei:profileDesc/preceding-sibling::tei:encodingDesc/tei:classDecl/tei:taxonomy[@xml:id = 'g']/tei:category[@xml:id=$genreID/tag[5]]/tei:catDesc"/></collex:genre>
        </xsl:if>
        </xsl:template>
    
    <!-- getting keywords -->
    
    <xsl:template match="tei:item" mode="kw">
        <dc:subject><xsl:value-of select="."/></dc:subject>
    </xsl:template>
    
    <!--getting parts -->
    <xsl:template match="tei:div[@type='collection']">
        <xsl:apply-templates select="tei:list/tei:item"/>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <dcterms:hasPart>
            <xsl:attribute name="rdf:resource">
                <xsl:value-of select="concat(substring-before(tei:ref/@target, '.html'), '.rdf')"/>
            </xsl:attribute>
        </dcterms:hasPart>
    </xsl:template>
  
</xsl:stylesheet>
