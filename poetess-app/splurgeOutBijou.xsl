<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs tei" version="2.0">

    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    <xsl:strip-space elements="*"/>
    
    <!--this needs to be fixed: I handcorrected some things -->

    <xsl:template match="/">
        <xsl:apply-templates/>
        <xsl:result-document href="../XML/list.xml">
            <xsl:call-template name="list"/>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="tei:div[not(@type = 'scene')]">
        <xsl:variable name="part">
            <xsl:for-each select=".">
                <xsl:value-of select="concat(@type, @xml:id)"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:variable name="id" select="@xml:id"/>
        <xsl:result-document href="bijou1828.{$part}.xml">
            <TEI xmlns="http://www.tei-c.org/ns/1.0">
                <teiHeader>
                    <fileDesc>
                        <titleStmt>
                            <title type="main">from The Bijou Literary Annual, 1828</title>
                            <title type="subordinate">
                                <xsl:choose>
                                    <xsl:when test="tei:head">
                                        <xsl:value-of select="normalize-space(tei:head[1])"/>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="normalize-space(*//tei:head[1])"/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </title>
                            <xsl:choose>
                                <xsl:when test="parent::tei:front and not(@type = 'preface')">
                                    <author type="producer">William Pickering</author>
                                </xsl:when>
                                <xsl:when test="parent::tei:back">
                                    <author type="producer">Laura Mandell</author>
                                </xsl:when>
                                <xsl:when test="@type = 'picture'">
                                    <author>
                                        <xsl:attribute name="type">
                                            <xsl:value-of
                                                select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[1]/@type"
                                            />
                                        </xsl:attribute>
                                        <xsl:value-of
                                            select="normalize-space(tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[1])"
                                        />
                                    </author>
                                    <xsl:if
                                        test="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]">
                                        <author>
                                            <xsl:attribute name="type">
                                                <xsl:value-of
                                                  select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]/@type"
                                                />
                                            </xsl:attribute>
                                            <xsl:value-of
                                                select="normalize-space(tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2])"
                                            />
                                        </author>
                                    </xsl:if>
                                </xsl:when>
                                <xsl:otherwise>
                                    <author type="author">
                                        <xsl:value-of
                                            select="normalize-space(tei:head[2])"
                                        />
                                    </author>
                                </xsl:otherwise>
                            </xsl:choose>
                            <editor role="editor">Fraser, William (1796-1854), compiler</editor>
                            <sponsor>Miami University</sponsor>
                            <sponsor>The Poetess Archive</sponsor>
                            <respStmt>
                                <resp>General Editor, and P5 encoding by </resp>
                                <name>Laura Mandell</name>
                                <name/>
                            </respStmt>
                            <respStmt>
                                <resp>Optically scanned by </resp>
                                <name>John Millard</name>
                                <name/>
                            </respStmt>
                            <respStmt>
                                <resp>Transcribing and proofreading by </resp>
                                <name>Zach Weir</name>
                                <name/>
                            </respStmt>
                        </titleStmt>
                        <editionStmt>
                            <edition>
                                <date>18280000</date>
                            </edition>
                        </editionStmt>
                        <extent>TEI formatted filesize uncompressed: approx. 684 kbytes</extent>
                        <publicationStmt>
                            <publisher>Laura Mandell, Texas A&amp;M University</publisher>
                            <pubPlace>College Station, TX</pubPlace>
                            <date>20170606</date>
                            <availability status="unknown">
                                <p>Freely available via a Creative Commons Attribution-ShareAlike
                                    4.0 International License</p>
                            </availability>
                            <idno>
                                <xsl:value-of select="concat('bijou1828.', $part)"/>
                            </idno>
                        </publicationStmt>
                        <seriesStmt>
                            <title>The Poetess Archive: an Electronic Collection</title>
                            <respStmt>
                                <name>Laura Mandell,</name>
                                <resp>General Editor.</resp>
                            </respStmt>
                        </seriesStmt>
                        <sourceDesc>
                            <biblStruct>
                                <analytic>
                                    <xsl:choose>
                                        <xsl:when
                                            test="parent::tei:front and not(@type = 'preface')">
                                            <author type="producer"><name reg="Pickering, William" date="1796-1854" place="UK">William Pickering</name></author>
                                        </xsl:when>
                                        <xsl:when test="parent::tei:back">
                                            <author type="producer"><name reg="Mandell, Laura Camilla" date="1958-0000" place="US">Laura Mandell</name></author>
                                        </xsl:when>
                                        <xsl:when test="@type = 'picture'">
                                            <author>
                                                <xsl:attribute name="type">
                                                  <xsl:value-of
                                                  select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[1]/@type"
                                                  />
                                                </xsl:attribute>
                                                <name>
                                                    <xsl:attribute name="reg">
                                                        <xsl:value-of select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[1]/tei:name/@reg"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="date">
                                                        <xsl:value-of select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[1]/tei:name/@date"/>
                                                    </xsl:attribute>
                                                    <xsl:attribute name="place">
                                                        <xsl:value-of select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[1]/tei:name/@place"/>
                                                    </xsl:attribute>
                                                <xsl:value-of
                                                  select="normalize-space(tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[1]/tei:name)"
                                                />
                                                </name>
                                            </author>
                                            <xsl:if
                                                test="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]">
                                                <author>
                                                  <xsl:attribute name="type">
                                                  <xsl:value-of
                                                  select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]/@type"
                                                  />
                                                  </xsl:attribute>
                                                    <name>
                                                        <xsl:attribute name="reg">
                                                            <xsl:value-of select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]/tei:name/@reg"/>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="date">
                                                            <xsl:value-of select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]/tei:name/@date"/>
                                                        </xsl:attribute>
                                                        <xsl:attribute name="place">
                                                            <xsl:value-of select="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]/tei:name/@place"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of
                                                            select="normalize-space(tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]/tei:name)"
                                                        />
                                                    </name>
                                                </author>
                                            </xsl:if>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <author type="author">
                                                <name>
                                                    <xsl:attribute name="reg"><xsl:value-of select="tei:head[2]/tei:name/@reg"/></xsl:attribute>
                                                    <xsl:attribute name="date"><xsl:value-of select="tei:head[2]/tei:name/@date"/></xsl:attribute>
                                                    <xsl:attribute name="place"><xsl:value-of select="tei:head[2]/tei:name/@place"/></xsl:attribute>
                                                    <!-- manually fix any names with more than 2 commas in the reg -->
                                                    <xsl:choose>
                                                        <xsl:when test="contains(substring-after(tei:head[2]/tei:name/@reg, ','), ',')">
                                                            <xsl:value-of select="substring-after(substring-after(tei:head[2]/tei:name/@reg, ','), ', ')"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="substring-before(substring-after(tei:head[2]/tei:name/@reg, ', '), ',')"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="substring-before(tei:head[2]/tei:name/@reg, ',')"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                    <xsl:value-of select="substring-after(tei:head[2]/tei:name/@reg, ', ')"/>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="substring-before(tei:head[2]/tei:name/@reg, ',')"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </name>
                                            </author>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                    <title>
                                        <xsl:choose>
                                            <xsl:when test="tei:head">
                                                <xsl:value-of select="normalize-space(tei:head[1])"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="normalize-space(*//tei:head[1])"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </title>
                                </analytic>
                                <monogr>
                                    <title level="m" type="main">The Bijou; </title>
                                    <title level="m" type="subordinate">or Annual of Literature and
                                        the Arts</title>
                                    <editor role="editor">
                                        <name reg="Fraser, William" date="1796-1854" place="UK">William Fraser</name>
                                    </editor>
                                    <imprint>
                                        <pubPlace>London</pubPlace>
                                        <publisher>
                                            <name reg="Pickering, William" date="1796-1854" place="UK">William Pickering</name>
                                        </publisher>
                                        <date>18280000</date>
                                        <xsl:if test="descendant::tei:pb/@n">
                                            <biblScope unit="pages">
                                                <xsl:choose>
                                                  <xsl:when
                                                  test="descendant::tei:pb[1]/@n != descendant::tei:pb[last()]/@n">
                                                  <xsl:value-of select="descendant::tei:pb[1]/@n"
                                                  />-<xsl:value-of
                                                  select="descendant::tei:pb[last()]/@n"/>
                                                  </xsl:when>
                                                  <xsl:otherwise>
                                                  <xsl:value-of select="descendant::tei:pb/@n"/>
                                                  </xsl:otherwise>
                                                </xsl:choose>
                                            </biblScope>
                                        </xsl:if>
                                    </imprint>
                                </monogr>
                            </biblStruct>
                            <bibl>This copy is transcribed from the volume held by Miami University
                                Special Collections Department. The page images come from the
                                Internet Archive: <ref
                                    target="https://archive.org/details/bijouorannualofl00lond"
                                    >Digitized by the Internet Archive in 2011 with funding from
                                    Duke University Libraries</ref>."</bibl>
                        </sourceDesc>
                    </fileDesc>
                    <encodingDesc>
                        <editorialDecl>
                            <p>This document follows the rules specified for TEI use by NINES.</p>
                            <p>All quotation marks and apostrophes have been transcribed as entity
                                references.</p>
                            <p>Any dashes occurring in line breaks have been removed.</p>
                            <p>Hyphens and dashes have been coded using HTML Entity Decimal for
                                Unicode.</p>
                            <p>Special characters (letters with accents, etc.) have been coded using
                                HTML Entity Decimal for Unicode.</p>
                            <p>Page numbers appear at the beginning of each page, no matter where
                                originally placed.</p>
                        </editorialDecl>
                        <classDecl>
                            <taxonomy xml:id="ps">
                                <bibl>Primary or Secondary</bibl>
                                <category xml:id="ps1">
                                    <catDesc>primary</catDesc>
                                </category>
                                <category xml:id="ps2">
                                    <catDesc>secondary</catDesc>
                                </category>
                            </taxonomy>
                            <taxonomy xml:id="g">
                                <bibl>Genre and Material Form</bibl>
                                <category xml:id="g1">
                                    <catDesc>pageimage</catDesc>
                                </category>
                                <category xml:id="g2">
                                    <catDesc>biography</catDesc>
                                </category>
                                <category xml:id="g3">
                                    <catDesc>biographical essay</catDesc>
                                </category>
                                <category xml:id="g4">
                                    <catDesc>poetry pamphlet</catDesc>
                                </category>
                                <category xml:id="g5">
                                    <catDesc>poetry book</catDesc>
                                </category>
                                <category xml:id="g6">
                                    <catDesc>poem</catDesc>
                                </category>
                                <category xml:id="g7">
                                    <catDesc>story</catDesc>
                                </category>
                                <category xml:id="g8">
                                    <catDesc>drama</catDesc>
                                </category>
                                <category xml:id="g9">
                                    <catDesc>table of contents</catDesc>
                                </category>
                                <category xml:id="g10">
                                    <catDesc>table of illustrations</catDesc>
                                </category>
                                <category xml:id="g11">
                                    <catDesc>picture</catDesc>
                                </category>
                                <category xml:id="g12">
                                    <catDesc>index</catDesc>
                                </category>
                                <category xml:id="g13">
                                    <catDesc>notes</catDesc>
                                </category>
                                <category xml:id="g14">
                                    <catDesc>frontispiece</catDesc>
                                </category>
                                <category xml:id="g15">
                                    <catDesc>inscription page</catDesc>
                                </category>
                                <category xml:id="g16">
                                    <catDesc>book boards</catDesc>
                                </category>
                                <category xml:id="g17">
                                    <catDesc>titlepage</catDesc>
                                </category>
                                <category xml:id="g18">
                                    <catDesc>preface</catDesc>
                                </category>
                                <category xml:id="g19">
                                    <catDesc>advertisement</catDesc>
                                </category>
                                <category xml:id="g20">
                                    <catDesc>foreword</catDesc>
                                </category>
                                <category xml:id="g21">
                                    <catDesc>acknowledgments</catDesc>
                                </category>
                                <category xml:id="g22">
                                    <catDesc>collection literary annual</catDesc>
                                </category>
                                <category xml:id="g23">
                                    <catDesc>collection miscellany</catDesc>
                                </category>
                                <category xml:id="g24">
                                    <catDesc>collection anthology</catDesc>
                                </category>
                                <category xml:id="g25">
                                    <catDesc>collection beauties</catDesc>
                                </category>
                                <category xml:id="g26">
                                    <catDesc>collection juvenile</catDesc>
                                </category>
                                <category xml:id="g27">
                                    <catDesc>collection religious</catDesc>
                                </category>
                                <category xml:id="g28">
                                    <catDesc>collection travels</catDesc>
                                </category>
                                <category xml:id="g29">
                                    <catDesc>mixed</catDesc>
                                </category>
                                <category xml:id="g30">
                                    <catDesc>essay</catDesc>
                                </category>
                                <category xml:id="g31">
                                    <catDesc>review</catDesc>
                                </category>
                                <category xml:id="g32">
                                    <catDesc>letter</catDesc>
                                </category>
                                <category xml:id="g33">
                                    <catDesc>fragment poem</catDesc>
                                </category>
                                <category xml:id="g34">
                                    <catDesc>fragment story</catDesc>
                                </category>
                                <category xml:id="g35">
                                    <catDesc>fragment novel</catDesc>
                                </category>
                                <category xml:id="g36">
                                    <catDesc>literary criticism book</catDesc>
                                </category>
                                <category xml:id="g37">
                                    <catDesc>literary criticism collection</catDesc>
                                </category>
                                <category xml:id="g38">
                                    <catDesc>bibliography</catDesc>
                                </category>
                                <category xml:id="g39">
                                    <catDesc>engraving</catDesc>
                                </category>
                                <category xml:id="g40">
                                    <catDesc>reproduction</catDesc>
                                </category>
                                <category xml:id="g41">
                                    <catDesc>figure</catDesc>
                                </category>
                                <category xml:id="g42">
                                    <catDesc>graph</catDesc>
                                </category>
                                <category xml:id="g43">
                                    <catDesc>map</catDesc>
                                </category>
                                <category xml:id="g44">
                                    <catDesc>table</catDesc>
                                </category>
                                <category xml:id="g45">
                                    <catDesc>musical score</catDesc>
                                </category>
                                <category xml:id="g46">
                                    <catDesc>music</catDesc>
                                </category>
                                <category xml:id="g47">
                                    <catDesc>satire</catDesc>
                                </category>
                                <category xml:id="g48">
                                    <catDesc>political pamphlet</catDesc>
                                </category>
                                <category xml:id="g49">
                                    <catDesc>political cartoon</catDesc>
                                </category>
                                <category xml:id="g50">
                                    <catDesc>periodical</catDesc>
                                </category>
                                <category xml:id="g51">
                                    <catDesc>historical monograph</catDesc>
                                </category>
                                <category xml:id="g52">
                                    <catDesc>historical essay</catDesc>
                                </category>
                                <category xml:id="g53">
                                    <catDesc>philosophical treatise</catDesc>
                                </category>
                                <category xml:id="g54">
                                    <catDesc>philosophical essay</catDesc>
                                </category>
                                <category xml:id="g55">
                                    <catDesc>religious pamphlet</catDesc>
                                </category>
                                <category xml:id="g56">
                                    <catDesc>sermon</catDesc>
                                </category>
                                <category xml:id="g57">
                                    <catDesc>theology</catDesc>
                                </category>
                                <category xml:id="g58">
                                    <catDesc>religious book</catDesc>
                                </category>
                                <category xml:id="g59">
                                    <catDesc>essay on education</catDesc>
                                </category>
                                <category xml:id="g60">
                                    <catDesc>educational treatise</catDesc>
                                </category>
                                <category xml:id="g61">
                                    <catDesc>list of subscribers</catDesc>
                                </category>
                                <category xml:id="g62">
                                    <catDesc>allegory</catDesc>
                                </category>
                                <category xml:id="g63">
                                    <catDesc>introduction</catDesc>
                                </category>
                                <category xml:id="g64">
                                    <catDesc>slipcase</catDesc>
                                </category>
                                <category xml:id="g65">
                                    <catDesc>dedication</catDesc>
                                </category>
                                <category xml:id="g66">
                                    <catDesc>picture of building</catDesc>
                                </category>
                                <category xml:id="g67">
                                    <catDesc>floorplans</catDesc>
                                </category>
                                <category xml:id="g68">
                                    <catDesc>photograph</catDesc>
                                </category>
                                <category xml:id="g69">
                                    <catDesc>translation</catDesc>
                                </category>
                                <category xml:id="g70">
                                    <catDesc>manuscript</catDesc>
                                </category>
                                <category xml:id="g71">
                                    <catDesc>printersmark</catDesc>
                                </category>
                            </taxonomy>
                            <taxonomy xml:id="keyword">
                                <category xml:id="lcsh">
                                    <catDesc>Library of Congress Subject Headings, reduced to one
                                        word before hyphen</catDesc>
                                </category>
                            </taxonomy>
                            <taxonomy>
                                <category xml:id="BL">
                                    <catDesc>British Library Shelf Mark</catDesc>
                                </category>
                            </taxonomy>
                        </classDecl>
                    </encodingDesc>
                    <profileDesc>
                        <textClass>
                            <keywords scheme="#lcsh">
                                <list type="simple">
                                    <item>Poetess</item>
                                    <item>The Bijou</item>
                                    <item>Literary Annual</item>
                                    <item>Fraser, William (1796-1854)</item>
                                    <item>
                                        <xsl:value-of select="@type"/>
                                    </item>
                                    <item>
                                        <xsl:choose>
                                            <xsl:when test="tei:head">
                                                <xsl:value-of select="normalize-space(tei:head[1])"
                                                />
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:value-of
                                                  select="normalize-space(descendant::tei:head[1])"
                                                />
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </item>
                                    <xsl:choose>
                                        <xsl:when
                                            test="parent::tei:front and not(@type = 'preface')">
                                            <item>William Pickering</item>
                                        </xsl:when>
                                        <xsl:when test="parent::tei:back">
                                            <item>Laura Mandell</item>
                                        </xsl:when>
                                        <xsl:when test="@type = 'picture'">
                                            <item>
                                                <xsl:value-of
                                                  select="normalize-space(substring-after(tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[1], 'by '))"
                                                />
                                            </item>
                                            <xsl:if
                                                test="tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2]">
                                                <item>
                                                  <xsl:value-of
                                                  select="normalize-space(substring-after(tei:p/tei:ref/tei:figure/tei:head/tei:bibl/tei:author[2], 'by '))"
                                                  />
                                                </item>
                                            </xsl:if>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <item>
                                                <xsl:value-of
                                                  select="normalize-space(substring-after(tei:head[2], 'By '))"
                                                />
                                            </item>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </list>
                            </keywords>
                            <catRef target="#ps1" scheme="#p"/>
                            <catRef>
                                <xsl:attribute name="target">
                                    <xsl:choose>
                                        <xsl:when test="@type = 'picture'">
                                            <xsl:text>#g11 #g39</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'boards'">
                                            <xsl:text>#g16</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'frontispiece'">
                                            <xsl:text>#g14</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'titlepage'">
                                            <xsl:text>#g17</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'dedicationpage'">
                                            <xsl:text>#g65</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'preface'">
                                            <xsl:text>#g18</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'illustrations'">
                                            <xsl:text>#g10</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'contents'">
                                            <xsl:text>#g9</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'printersMark'">
                                            <xsl:text>#g71</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'index'">
                                            <xsl:text>#g12</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="contains($id, 'S')">
                                            <xsl:text>#g7</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="contains($id, 'D')">
                                            <xsl:text>#g8</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="contains($id, 'P')">
                                            <xsl:text>#g6</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="contains($id, 'L')">
                                            <xsl:text>#g32</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'picture'">
                                            <xsl:text>#g11 #g39</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'boards'">
                                            <xsl:text>#g16</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'frontispiece'">
                                            <xsl:text>#g14</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'titlepage'">
                                            <xsl:text>#g17</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'dedicationpage'">
                                            <xsl:text>#g65</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'preface'">
                                            <xsl:text>#g18</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'illustrations'">
                                            <xsl:text>#g10</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'contents'">
                                            <xsl:text>#g9</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'printersMark'">
                                            <xsl:text>#g71</xsl:text>
                                        </xsl:when>
                                        <xsl:when test="@type = 'index'">
                                            <xsl:text>#g12</xsl:text>
                                        </xsl:when>
                                    </xsl:choose>
                                </xsl:attribute>
                                <xsl:attribute name="scheme">
                                    <xsl:text>#g</xsl:text>
                                </xsl:attribute>
                            </catRef>
                        </textClass>
                    </profileDesc>
                    <revisionDesc>
                        <change>
                            <date>20170602</date>
                            <label>transformed to P5, adding images, and cleaned up TEI</label>
                            <name>Laura Mandell</name>
                        </change>
                        <change><date>20051024</date><label>encoding by </label><name>Laura Mandell
                                and Zach Weir</name> XML coding; XSL application: Oxygen</change>
                    </revisionDesc>
                </teiHeader>
                <text>
                    <front>
                        <titlePage>
                            <docTitle>
                                <titlePart type="main">The Bijou; </titlePart>
                                <titlePart type="subordinate">or Annual of Literature and the Arts</titlePart>
                            </docTitle>
                            <docAuthor>compiled by <name reg="Fraser, William" date="1796-1854" place="UK">William Fraser</name>
                            </docAuthor>
                            <docImprint>
                                <publisher><name reg="Pickering, William" date="1796-1854" place="UK">William Pickering</name></publisher>
                                <pubPlace>London</pubPlace>
                            </docImprint>
                            <docDate>1828</docDate>
                        </titlePage>
                    </front>
                    <body>
                        <xsl:for-each select=".">
                            <xsl:copy>
                                <xsl:apply-templates select="@* | node()"/>
                            </xsl:copy>
                        </xsl:for-each>
                    </body>
                </text>
            </TEI>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="tei:div" mode="list">
        <xsl:variable name="part">
            <xsl:for-each select=".">
                <xsl:value-of select="concat(@type, @xml:id)"/>
            </xsl:for-each>
        </xsl:variable>
        <xsl:if test="not(@type = 'scene')">
            <item>
                <xsl:attribute name="code">
                    <xsl:value-of select="concat('bijou1828.', $part, '.xml')"/>
                </xsl:attribute>
            </item>
        </xsl:if>
    </xsl:template>

    <xsl:template name="list">
        <list>
            <item code="bijou1828-p5.xml"/>
            <xsl:for-each select="descendant::tei:div">
                <xsl:apply-templates select="." mode="list"/>
            </xsl:for-each>
        </list>
    </xsl:template>

</xsl:stylesheet>
