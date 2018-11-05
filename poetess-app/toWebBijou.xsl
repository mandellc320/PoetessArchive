<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="xs tei" version="2.0">

	<!-- script for converting XML-TEI to HTML. 		
	Laura Mandell on 05/27/18 
	00-began with fork from /xslt/masters/HTMLtransform.xsl
	01-filled master with needed code
	02-revised plays, simplified by eliminating TOC (toWebComplete.xsl)
	03-created for critarchive 10/17/18 (toWebCritArchive.xsl)
	04-re-used for bijou 10/21/18, and added back elements from 02 (toWebBijou.xsl)
-->

	<!-- Here is the document declaration necessary for an HTML5 (web) page -->

	<xsl:output method="html" doctype-system="about:legacy-compat" omit-xml-declaration="yes"
		indent="yes" encoding="UTF-8"/>
	<xsl:strip-space elements="*"/>

	<!-- Make these variables so that you can easily change them. -->
	<xsl:variable name="stylesheet">bijou.css</xsl:variable>
	<xsl:variable name="baseURL">http://www.poetessarchive.org/bijou/</xsl:variable>

	<!-- running multiple documents via a list -->
	<xsl:template match="list">
		<xsl:for-each select="item">
			<xsl:apply-templates select="document(@code)/tei:TEI"/>
		</xsl:for-each>
	</xsl:template>

	<!--structuring the document-->

	<xsl:template match="tei:TEI">
		<xsl:variable name="filename">
			<xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno"/>
		</xsl:variable>
		<xsl:variable name="mainTitle"
			select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type = 'main']"/>
		<xsl:variable name="subTitle"
			select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title[@type = 'subordinate']"/>
		<xsl:variable name="author" select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:author"/>
		<xsl:result-document href="../HTML/{$filename}.html">
			<html>
				<head prefix="og: http://ogp.me/ns#">
					<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
					<meta property="og:title">
						<xsl:attribute name="content">
							<xsl:choose>
								<xsl:when test="contains($mainTitle, 'from')">
									<xsl:value-of select="$mainTitle"/>
									<xsl:text> - </xsl:text>
									<xsl:value-of select="$subTitle"/>
									<xsl:text> by </xsl:text>
									<xsl:value-of select="$author"/>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of
										select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
									<xsl:text> by </xsl:text>
									<xsl:value-of select="$author"/>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
					</meta>
					<meta property="og:type" content="website"/>
					<meta property="og:url" content="{$baseURL}/HTML/{$filename}.html"/>
					<!--this will need to be changed -->
					<meta property="og:image"
						content="http://www.poetessarchive.org/PA-thumbnail-2.gif"/>
					<!--this will need to be changed -->
					<meta property="og:description"
						content="A literary work or image from the Poetess Archive"/>
					<meta property="og:site_name" content="The Poetess Archive"/>
					<!--This HTML document has been generated from a TEI Master: do not edit.-->
					<title>
						<xsl:choose>
							<xsl:when test="contains($mainTitle, 'from')">
								<xsl:value-of select="$mainTitle"/>
								<xsl:text> - </xsl:text>
								<xsl:value-of select="$subTitle"/>
								<xsl:text>, </xsl:text>
								<xsl:value-of select="$author"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of
									select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
								<xsl:text>, </xsl:text>
								<xsl:value-of select="$author"/>
							</xsl:otherwise>
						</xsl:choose>
					</title>
					<link rel="stylesheet" type="text/css" href="{$stylesheet}"/>
					<!-- Fonts -->
					<link href="https://fonts.googleapis.com/css?family=Cormorant+Garamond"
						rel="stylesheet"/>
					<script src="https://hypothes.is/embed.js" async=""/>
				</head>
				<body>
					<xsl:apply-templates select="tei:text"/>
					<section class="noteSpace"/>
				</body>
			</html>
		</xsl:result-document>
	</xsl:template>

	<!-- =======================================================
	   front templates -->

	<xsl:template match="tei:front">
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:titlePage">
		<section class="titlePage">
			<xsl:apply-templates/>
		</section>
	</xsl:template>

	<xsl:template match="tei:titlePart">
		<h2 class="tp">
			<xsl:apply-templates/>
		</h2>
	</xsl:template>

	<xsl:template match="tei:docAuthor">
		<h3 class="tp">
			<xsl:apply-templates/>
		</h3>
	</xsl:template>

	<xsl:template match="tei:docDate">
		<h4 class="tp">
			<xsl:apply-templates/>
		</h4>
	</xsl:template>

	<xsl:template match="tei:docImprint">
		<p class="pnoindent">
			<xsl:text>London: </xsl:text>
			<xsl:apply-templates select="tei:publisher"/>
			<xsl:text>, </xsl:text>
			<xsl:apply-templates select="tei:date"/>
		</p>
	</xsl:template>

	<xsl:template match="tei:docEdition">
		<xsl:choose>
			<xsl:when test="tei:bibl/tei:biblScope/@unit">
				<p>
					<xsl:text>Vol. </xsl:text>
					<xsl:value-of select="tei:bibl/tei:biblScope[@unit = 'volume']"/>
					<xsl:text>, </xsl:text>
					<xsl:text>pp. </xsl:text>
					<xsl:value-of select="tei:bibl/tei:biblScope[@unit = 'page']"/>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p class="tp">
					<xsl:apply-templates/>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>


	<!-- =======================================================
	         body templates used by all types of documents -->

	<xsl:template match="tei:text">
		<main>
			<img
				src="http://iiif.dh.tamu.edu/iiif/2/poetess/bijou/010.tif/200,360,1550,180/960,/0/gray.jpg"
				class="partHead" alt="The Bijou"/>
			<xsl:apply-templates/>
			<xsl:if test="//tei:note">
				<section class="notes">
					<header>Notes</header>
					<xsl:apply-templates select="//tei:note" mode="end"/>
				</section>
			</xsl:if>
		</main>
	</xsl:template>

	<xsl:template match="tei:div">
		<xsl:variable name="nbrPB">
			<xsl:value-of select="count(descendant::tei:pb)"/>
		</xsl:variable>
		<xsl:variable name="pages">
			<xsl:choose>
				<xsl:when test="$nbrPB &gt; 1">
					<xsl:value-of
						select="concat('pp. ', descendant::tei:pb[1]/@n, '-', descendant::tei:pb[last()]/@n)"
					/>
				</xsl:when>
				<xsl:when test="$nbrPB = 1">
					<xsl:value-of select="concat('p. ', descendant::tei:pb/@n)"/>
				</xsl:when>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="URL" select="concat($baseURL, 'XML/bijou1828.', @type, @xml:id, '.xml')"/>
		<!--needs to be switched to local tei file link -->
		<xsl:choose>
			<xsl:when test=".[@type = 'poem'] |.[@type='drama'] | .[@type='scene']">
				<xsl:choose>
					<xsl:when test="following-sibling::tei:div | preceding-sibling::tei:div">
						<section id="{@xml:id}">
							<xsl:attribute name="class" select="@type"/>
							<xsl:apply-templates/>
						</section>
					</xsl:when>
					<xsl:otherwise>
						<section id="@xml:id">
							<xsl:attribute name="class" select="@type"/>
							<xsl:apply-templates/>
							<table class="tei">
								<tr>
									<td class="a">
										<h5>from <a
												href="http://www.poetessarchive.org/bijou/HTML/bijou1828-p5.html">
											<em>The Bijou</em>, 1828</a>
											<xsl:choose>
												<xsl:when test="not(descendant::tei:pb)"/>
												<xsl:when test="not(descendant::tei:pb/@n)"/>
												<xsl:otherwise>
													<xsl:text>, </xsl:text>
													<xsl:value-of select="$pages"/>
												</xsl:otherwise>
											</xsl:choose>
										</h5>
									</td>
									<td class="b">
										<a>
											<xsl:attribute name="href">
												<xsl:value-of
												select="concat($baseURL, 'XML/bijou1828.', @type, @xml:id, '.xml')"
												/>
											</xsl:attribute>
											<img class="tei" src="download.png"
												alt="TEI-encoded version"/>
										</a>
									</td>
									<!--tei image needs to be local -->
								</tr>
							</table>
						</section>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="@type = 'index'">
				<xsl:choose>
					<xsl:when test="following-sibling::tei:div | preceding-sibling::tei:div">
						<section id="{@xml:id}">
							<xsl:attribute name="class" select="@type"/>
							<xsl:apply-templates select="tei:head"/>
							<br/>
							<table>
								<xsl:attribute name="class" select="@type"/>
								<xsl:apply-templates select="tei:bibl"/>
							</table>
						</section>
					</xsl:when>
					<xsl:otherwise>
						<section id="@xml:id">
							<xsl:attribute name="class" select="@type"/>
							<xsl:apply-templates select="tei:head"/>
							<br/>
							<table>
								<xsl:attribute name="class" select="@type"/>
								<xsl:apply-templates select="tei:bibl"/>
							</table>
						</section>
							<table class="tei">
								<tr>
									<td class="a">
										<h5>from <a
												href="http://www.poetessarchive.org/bijou/HTML/bijou1828-p5.html"
												><em>The Bijou</em>, 1828</a></h5>
									</td>
									<td class="b">
										<a>
											<xsl:attribute name="href">
												<xsl:value-of
												select="concat($baseURL, 'XML/bijou1828.', @type, @xml:id, '.xml')"
												/>
											</xsl:attribute>
											<img class="tei" src="download.png"
												alt="TEI-encoded version"/>
										</a>
									</td>
									<!--tei image needs to be local -->
								</tr>
							</table>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="following-sibling::tei:div | preceding-sibling::tei:div">
						<section id="{@xml:id}">
							<xsl:attribute name="class" select="@type"/>
							<xsl:apply-templates/>
						</section>
					</xsl:when>
					<xsl:otherwise>
						<section id="{@xml:id}">
							<xsl:attribute name="class" select="@type"/>
							<xsl:apply-templates/>
							<table class="tei">
								<tr>
									<td class="a">
										<h5>from <a
											href="http://www.poetessarchive.org/bijou/HTML/bijou1828-p5.html">
											<em>The Bijou</em>, 1828</a>
											<xsl:choose>
												<xsl:when test="not(descendant::tei:pb)"/>
												<xsl:when test="not(descendant::tei:pb/@n)"/>
												<xsl:otherwise>
													<xsl:text>, </xsl:text>
													<xsl:value-of select="$pages"/>
												</xsl:otherwise>
											</xsl:choose>
										</h5>
									</td>
									<td class="b">
										<a>
											<xsl:attribute name="href">
												<xsl:value-of
												select="concat($baseURL, 'XML/bijou1828.', @type, @xml:id, '.xml')"
												/>
											</xsl:attribute>
											<img class="tei" src="download.png"
												alt="TEI-encoded version"/>
										</a>
									</td>
									<!--tei image needs to be local -->
								</tr>
							</table>
						</section>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:head">
		<xsl:choose>
			<xsl:when test="tei:bibl">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:when test="parent::tei:figure">
				<br/>
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<header>
					<xsl:apply-templates/>
				</header>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="@rendition">
		<xsl:value-of select="substring-after(., '#')"/>
	</xsl:template>

	<xsl:template match="tei:title">
		<xsl:choose>
			<xsl:when test="preceding-sibling::tei:title">
				<xsl:text>, </xsl:text>
				<span>
					<xsl:attribute name="class">
						<xsl:apply-templates select="@rend | @rendition"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<span>
					<xsl:attribute name="class">
						<xsl:apply-templates select="@rend | @rendition"/>
					</xsl:attribute>
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:figure/tei:head">
		<br/>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:graphic">
		<xsl:variable name="imageNbr" select="substring-after(parent::tei:figure/@xml:id, 'image')"/>
		<xsl:variable name="imageURL">
			<xsl:value-of
				select="concat('http://iiif.dh.tamu.edu/iiif/2/poetess/bijou/', $imageNbr, '.tif/full/full/0/default.jpg')"
			/>
		</xsl:variable>
		<a href="{$imageURL}">
			<img src="{@url}"
				alt="a picture of {parent::tei:figure/parent::tei:div[@type='picture']/tei:head}"/>
		</a>
	</xsl:template>

	<xsl:template match="tei:figDesc">
		<br/>
		<xsl:apply-templates/>
	</xsl:template>

	<xsl:template match="tei:lg">
		<xsl:choose>
			<xsl:when test="parent::tei:div[@type = 'poem']">
				<table>
					<xsl:attribute name="class" select="parent::tei:div/@type"/>
					<xsl:apply-templates/>
				</table>
			</xsl:when>
			<xsl:when test="parent::tei:sp/parent::tei:div[@type='scene']">
				<table>
					<xsl:attribute name="class" select="parent::tei:sp/parent::tei:div/@type"/>
					<xsl:apply-templates/>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<table>
					<xsl:apply-templates/>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:epigraph">
		<xsl:choose>
			<xsl:when test="tei:l">
				<table class="epigraph">
					<xsl:apply-templates select="tei:l"/>
					<xsl:apply-templates select="tei:bibl"/>
				</table>
			</xsl:when>
			<xsl:otherwise>
				<section class="epigraph">
			<xsl:apply-templates/>
				</section>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:q">
		<xsl:text>&quot;</xsl:text>
		<xsl:apply-templates/>
		<xsl:text>&quot;</xsl:text>
	</xsl:template>

	<xsl:template match="tei:quote">
		<xsl:choose>
			<xsl:when test="parent::tei:p | parent::tei:note">
				<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
				<blockquote>
					<xsl:choose>
						<xsl:when test="tei:p">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:when test="tei:lg">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:otherwise>
							<p class="pnoindent">
								<xsl:apply-templates/>
							</p>
						</xsl:otherwise>
					</xsl:choose>
				</blockquote>
				<xsl:text disable-output-escaping="yes"><![CDATA[<p class="pnoindent">]]></xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<blockquote>
					<xsl:choose>
						<xsl:when test="tei:p">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:when test="tei:lg">
							<xsl:apply-templates/>
						</xsl:when>
						<xsl:otherwise>
							<p class="pnoindent">
								<xsl:apply-templates/>
							</p>
						</xsl:otherwise>
					</xsl:choose>
				</blockquote>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:bibl">
		<xsl:choose>
			<xsl:when test="parent::tei:head/parent::tei:div[@type = 'essay']">
				<header class="headBibl">
					<xsl:apply-templates select="tei:author"/>
				</header>
				<header class="headBibl">
					<xsl:apply-templates select="tei:title"/>
				</header>
			</xsl:when>
			<xsl:when test="parent::tei:epigraph">
				<xsl:choose>
					<xsl:when test="preceding-sibling::tei:l">
						<tr><td class="epigCite"><xsl:apply-templates/></td></tr>
					</xsl:when>
					<xsl:otherwise>
						<span class="epigCite">
					<xsl:apply-templates/>
						</span>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="parent::tei:div[@type = 'index']">
				<tr class="index">
					<td class="index">
						<xsl:apply-templates select="tei:author"/>
					</td>
					<td class="index">
						<xsl:apply-templates select="tei:title"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:l">
		<xsl:variable name="nbr">
			<xsl:number from="tei:div" level="any"/>
		</xsl:variable>
		<xsl:variable name="epigNbr" select="count(parent::tei:lg/parent::tei:div/tei:epigraph/tei:l)"/>
		<xsl:choose>
			<xsl:when test="parent::tei:lg/parent::tei:div[@type = 'poem'] | parent::tei:lg/parent::tei:sp/parent::tei:div[@type='scene']">
				<tr>
					<td class="a">
						<span>
							<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="@rendition">
										<xsl:apply-templates select="@rendition"/>
									</xsl:when>
									<xsl:when test="@rend">
										<xsl:value-of select="@rend"/>
									</xsl:when>
									<xsl:when test="@type">
										<xsl:value-of select="@type"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>l</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:apply-templates/>
						</span>
					</td>
					<td class="b">
						<xsl:value-of select="number($nbr) - number($epigNbr)"/>
					</td>
				</tr>
			</xsl:when>
			<xsl:when test="parent::tei:lg">
				<tr>
					<td>
						<span>
							<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="@rendition">
										<xsl:apply-templates select="@rendition"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>l</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:apply-templates/>
						</span>
					</td>
				</tr>
			</xsl:when>
			<xsl:when test="parent::tei:epigraph">
				<tr>
					<td class="epigLines">
						<xsl:apply-templates/>
					</td>
				</tr>
			</xsl:when>
			<xsl:otherwise>
				<span>
					<xsl:attribute name="class">
						<xsl:choose>
							<xsl:when test="@rendition">
								<xsl:apply-templates select="@rendition"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>l</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:attribute>
					<xsl:apply-templates/>
				</span>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:p">
		<xsl:choose>
			<xsl:when test="parent::tei:stage">
				<p class="stage">
				<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="parent::tei:epigraph">
				<p class="epigPara">
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:otherwise>
		<p>
			<xsl:choose>
				<xsl:when test="@rendition | @rend">
					<xsl:attribute name="class">
						<xsl:apply-templates select="@rendition | @rend"/>
					</xsl:attribute>
				</xsl:when>
				<xsl:when test="@type">
					<xsl:attribute name="class" select="@type"/>
				</xsl:when>
			</xsl:choose>
			<xsl:apply-templates/>
		</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:lb">
		<br/>
	</xsl:template>

	<xsl:template match="tei:hi">
		<span>
			<xsl:attribute name="class">
				<xsl:apply-templates select="@rendition | @rend"/>
			</xsl:attribute>
			<xsl:apply-templates/>
		</span>
	</xsl:template>

	<xsl:template match="tei:emph">
		<em>
			<xsl:value-of select="."/>
		</em>
	</xsl:template>

	<xsl:template match="tei:ref">
		<xsl:variable name="PAid">
			<xsl:value-of select="substring-after(@target, '#')"/>
		</xsl:variable>
		<xsl:variable name="PAtype">
			<xsl:choose>
				<xsl:when test="$PAid='FP'"><xsl:text>frontispiece</xsl:text></xsl:when>
				<xsl:when test="contains($PAid, 'P')"><xsl:text>poem</xsl:text></xsl:when>
				<xsl:when test="contains($PAid, 'S')"><xsl:text>story</xsl:text></xsl:when>
				<xsl:when test="contains($PAid, 'D')"><xsl:text>drama</xsl:text></xsl:when>
				<xsl:when test="contains($PAid, 'L')"><xsl:text>letter</xsl:text></xsl:when>
				<xsl:when test="contains($PAid, 'F')"><xsl:text>picture</xsl:text></xsl:when>
				<xsl:when test="contains($PAid, 'I')"><xsl:text>index</xsl:text></xsl:when>
				<xsl:otherwise><xsl:text>ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ</xsl:text>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:choose>
			<xsl:when test="ancestor-or-self::tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:biblStruct/tei:analytic">
				<a href="bijou1828.{$PAtype}{$PAid}.html"><xsl:apply-templates/></a>
			</xsl:when>
			<xsl:otherwise>
		<a href="{@target}">
			<xsl:apply-templates/>
		</a>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="tei:ab">
		<p>
			<xsl:if test="@rend">
				<xsl:attribute name="class" select="@rend"/>
			</xsl:if>
			<xsl:apply-templates/>
		</p>				
	</xsl:template>

	<xsl:template match="tei:list">
		<xsl:choose>
			<xsl:when test="@type = 'gloss'">
				<dl>
					<xsl:apply-templates/>
				</dl>
			</xsl:when>
			<xsl:otherwise>
				<ul>
					<xsl:apply-templates/>
				</ul>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:item">
		<xsl:choose>
			<xsl:when test="parent::tei:list[@type = 'gloss']">
				<xsl:apply-templates/>
			</xsl:when>
			<xsl:otherwise>
				<li>
					<xsl:apply-templates/>
				</li>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:term">
		<dt>
			<xsl:apply-templates/>
		</dt>
	</xsl:template>

	<xsl:template match="tei:gloss">
		<dd>
			<xsl:apply-templates/>
		</dd>
	</xsl:template>

	<xsl:template match="tei:stage">
		<xsl:choose>
			<xsl:when test="parent::tei:l">
				<span>
					<xsl:attribute name="class" select="@type"/>
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:when test=".[@type='exit'] | .[@type='entrance']">
				<p>
					<xsl:attribute name="class" select="@type"/>
					<xsl:apply-templates/>
				</p>
			</xsl:when>
			<xsl:when test="@type='delivery'">
				<xsl:choose>
					<xsl:when test="parent::tei:lg | parent::tei:p">
				<span class="delivery">
					<xsl:apply-templates/>
				</span>
					</xsl:when>
					<xsl:otherwise>
						<p class="delivery">
							<xsl:apply-templates/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="tei:p">
						<xsl:apply-templates/>
					</xsl:when>
					<xsl:otherwise>
						<p>
							<xsl:attribute name="class">
								<xsl:choose>
									<xsl:when test="@type">
										<xsl:value-of select="@type"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>stage</xsl:text>
									</xsl:otherwise>
								</xsl:choose>
							</xsl:attribute>
							<xsl:apply-templates/>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="tei:speaker">
		<p class="speaker">
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="tei:salute | tei:signed">
		<p>
			<xsl:if test="@rend">
				<xsl:attribute name="class">
					<xsl:value-of select="@rend"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<xsl:template name="pageNandI">
		<xsl:param name="img"/>
		<xsl:param name="nbr"/>
		<xsl:variable name="imgNbr">
			<xsl:value-of select="substring-after($img, 'image')"/>
		</xsl:variable>
		<xsl:variable name="URL">
			<xsl:value-of select="concat('http://iiif.dh.tamu.edu/iiif/2/poetess/bijou/', $imgNbr, '.tif/full/full/0/default.jpg')"/>
		</xsl:variable>
		<table class="pageNumber" id="{$imgNbr}">
			<tr><td class="a">
			<xsl:text>[Page </xsl:text>
			<xsl:value-of select="@n"/>
			<xsl:text>]</xsl:text>
			</td>
				<td class="b"><a href="#{$imgNbr}">
					<xsl:attribute name="onclick">
						<xsl:text disable-output-escaping="yes"><![CDATA[window.open(']]></xsl:text><xsl:value-of select="$URL"/><xsl:text disable-output-escaping="yes"><![CDATA[', 'newwindow', 'width=600, height=900')]]></xsl:text>
					</xsl:attribute>
					<img class="pageImage" alt="page image and link" src="http://iiif.dh.tamu.edu/iiif/2/poetess/bijou/{$imgNbr}.tif/full/,70/0/default.jpg'" />
				</a></td>
			</tr>
		</table>
	</xsl:template>

	<xsl:template match="tei:pb">
		<xsl:choose>
			<xsl:when test="parent::tei:div[@type='scene']">
				<hr />
				<xsl:call-template name="pageNandI">
					<xsl:with-param name="img" select="@xml:id"/>
					<xsl:with-param name="nbr" select="@n"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:when test="parent::tei:div[@type='picture']">
				<hr />
				<xsl:choose>
					<xsl:when test="@n">
						<table class="pageNumber">
							<tr><td class="a">
								<xsl:text>[Page </xsl:text>
								<xsl:value-of select="@n"/>
								<xsl:text>]</xsl:text>
							</td>
								<td class="b">&#160;</td>
							</tr>
						</table>
					</xsl:when>
					<xsl:otherwise>
						<table class="pageNumber">
							<tr><td class="a">
								<xsl:text>[np]</xsl:text>
							</td>
								<td class="b">&#160;</td>
							</tr>
						</table>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="parent::tei:quote">
				<xsl:choose>
					<xsl:when test="parent::tei:quote/parent::tei:p">
						<xsl:text disable-output-escaping="yes"><![CDATA[</blockquote></p>]]></xsl:text>
						<hr />
						<xsl:call-template name="pageNandI">
							<xsl:with-param name="img" select="@xml:id"/>
							<xsl:with-param name="nbr" select="@n"/>
						</xsl:call-template>
						<xsl:text disable-output-escaping="yes"><![CDATA[<p class="pnoindent"><blockquote>]]></xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text disable-output-escaping="yes"><![CDATA[</blockquote>]]></xsl:text>
						<hr />
						<xsl:call-template name="pageNandI">
							<xsl:with-param name="img" select="@xml:id"/>
							<xsl:with-param name="nbr" select="@n"/>
						</xsl:call-template>
						<xsl:text disable-output-escaping="yes"><![CDATA[<blockquote>]]></xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="parent::tei:p">
				<xsl:choose>
					<xsl:when test="parent::tei:p/parent::tei:quote">
						<xsl:text disable-output-escaping="yes"><![CDATA[</p></blockquote>]]></xsl:text>
						<hr />
						<xsl:call-template name="pageNandI">
							<xsl:with-param name="img" select="@xml:id"/>
							<xsl:with-param name="nbr" select="@n"/>
						</xsl:call-template>
						<xsl:text disable-output-escaping="yes"><![CDATA[<blockquote><p class="pnoindent">]]></xsl:text>
					</xsl:when>
					<xsl:otherwise>
						<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
						<hr />
						<xsl:call-template name="pageNandI">
							<xsl:with-param name="img" select="@xml:id"/>
							<xsl:with-param name="nbr" select="@n"/>
						</xsl:call-template>
						<xsl:text disable-output-escaping="yes"><![CDATA[<p class="pnoindent">]]></xsl:text>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="parent::tei:lg/parent::tei:quote">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table></blockquote>]]></xsl:text>
				<hr />
				<xsl:call-template name="pageNandI">
					<xsl:with-param name="img" select="@xml:id"/>
					<xsl:with-param name="nbr" select="@n"/>
				</xsl:call-template>
				<xsl:text disable-output-escaping="yes"><![CDATA[<blockquote><table class="poem">]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:lg/parent::sp/parent::tei:div[@type='scene']">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>
				<hr />
				<xsl:call-template name="pageNandI">
					<xsl:with-param name="img" select="@xml:id"/>
						<xsl:with-param name="nbr" select="@n"/>
				</xsl:call-template>
				<xsl:text disable-output-escaping="yes"><![CDATA[<table class="scene">]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:lg">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>
				<hr />
				<xsl:call-template name="pageNandI">
					<xsl:with-param name="img" select="@xml:id"/>
					<xsl:with-param name="nbr" select="@n"/>
				</xsl:call-template>
				<xsl:text disable-output-escaping="yes"><![CDATA[<table class="poem">]]></xsl:text>
			</xsl:when>
			<xsl:when test="preceding-sibling::tei:p | preceding-sibling::tei:lg">
				<hr />
				<xsl:call-template name="pageNandI">
					<xsl:with-param name="img" select="@xml:id"/>
					<xsl:with-param name="nbr" select="@n"/>
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="pageNandI">
					<xsl:with-param name="img" select="@xml:id"/>
					<xsl:with-param name="nbr" select="@n"/>
				</xsl:call-template>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

<!--	Used by critarchive:
		<xsl:template match="tei:milestone">
		<xsl:choose>
			<xsl:when test="preceding-sibling::tei:fw[1]"/>
			<xsl:when test="parent::tei:p/parent::tei:quote">
				<xsl:text disable-output-escaping="yes"><![CDATA[</p></blockquote>]]></xsl:text>
				<table class="milestone">
					<tr>
						<td>
							<xsl:value-of select="@n"/>
						</td>
					</tr>
				</table>
				<xsl:text disable-output-escaping="yes"><![CDATA[<blockquote><p class="pnoindent">]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:p">
				<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
				<table class="milestone">
					<tr>
						<td>
							<xsl:value-of select="@n"/>
						</td>
					</tr>
				</table>
				<xsl:text disable-output-escaping="yes"><![CDATA[<p class="pnoindent">]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:lg/parent::tei:quote">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table></blockquote>]]></xsl:text>
				<table class="milestone">
					<tr>
						<td>
							<xsl:value-of select="@n"/>
						</td>
					</tr>
				</table>
				<xsl:text disable-output-escaping="yes"><![CDATA[<blockquote><table>]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:lg">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>
				<table class="milestone">
					<tr>
						<td>
							<xsl:value-of select="@n"/>
						</td>
					</tr>
				</table>
				<xsl:text disable-output-escaping="yes"><![CDATA[<table>]]></xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<table class="milestone">
					<tr>
						<td>
							<xsl:value-of select="@n"/>
						</td>
					</tr>
				</table>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="tei:fw">
		<xsl:choose>
			<xsl:when test="parent::tei:quote">
				<xsl:text disable-output-escaping="yes"><![CDATA[</blockquote>]]></xsl:text>
				<xsl:call-template name="fwTable"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[<blockquote>]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:p/parent::tei:quote">
				<xsl:text disable-output-escaping="yes"><![CDATA[</p></blockquote>]]></xsl:text>
				<xsl:call-template name="fwTable"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[<blockquote><p class="pnoindent">]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:p">
				<xsl:text disable-output-escaping="yes"><![CDATA[</p>]]></xsl:text>
				<xsl:call-template name="fwTable"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[<p class="pnoindent">]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:lg/parent::tei:quote">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table></blockquote>]]></xsl:text>
				<xsl:call-template name="fwTable"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[<blockquote><table>]]></xsl:text>
			</xsl:when>
			<xsl:when test="parent::tei:lg">
				<xsl:text disable-output-escaping="yes"><![CDATA[</table>]]></xsl:text>
				<xsl:call-template name="fwTable"/>
				<xsl:text disable-output-escaping="yes"><![CDATA[<table>]]></xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="fwTable"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template name="fwTable">
		<table style="width:100%" class="fw">
			<xsl:choose>
				<xsl:when test="following-sibling::tei:milestone[1]">
					<tr>
						<td class="mlst1">
							<p>
								<xsl:if test="@rendition">
									<xsl:attribute name="class">
										<xsl:apply-templates select="@rendition"/>
									</xsl:attribute>
								</xsl:if>
								<xsl:apply-templates/>
							</p>
						</td>
						<td class="mlst2">
							<xsl:value-of select="following-sibling::tei:milestone[1]/@n"/>
						</td>
						<td class="mlst3">
							<xsl:text> </xsl:text>
						</td>
					</tr>
				</xsl:when>
				<xsl:otherwise>
					<tr>
						<td>
							<p>
								<xsl:if test="@rendition">
									<xsl:attribute name="class">
										<xsl:apply-templates select="@rendition"/>
									</xsl:attribute>
								</xsl:if>
								<xsl:apply-templates/>
							</p>
						</td>
					</tr>
				</xsl:otherwise>
			</xsl:choose>
		</table>
	</xsl:template> -->

	<xsl:template match="tei:salute | tei:signed">
		<p>
			<xsl:if test="@rend">
				<xsl:attribute name="class">
					<xsl:value-of select="@rend"/>
				</xsl:attribute>
			</xsl:if>
			<xsl:apply-templates/>
		</p>
	</xsl:template>

	<xsl:template match="tei:imprint">
		<xsl:text>, Vol. </xsl:text>
		<xsl:value-of select="tei:biblScope[@unit = 'volume']"/>
		<xsl:text> (</xsl:text>
		<xsl:value-of select="tei:date"/>
		<xsl:text>), </xsl:text>
		<xsl:text>pp. </xsl:text>
		<xsl:value-of select="tei:biblScope[@unit = 'page']"/>
	</xsl:template>

	<xsl:template match="tei:binaryObject">
		<p>
			<xsl:value-of select="."/>
		</p>
	</xsl:template>


	<!-- =======================================================
	   notes -->

	<xsl:template match="tei:note">
		<xsl:variable name="noteNBR">
			<xsl:number select="." level="any"/>
		</xsl:variable>
		<a>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="$noteNBR"/>
			</xsl:attribute>
			<xsl:attribute name="id" select="concat('back', $noteNBR)"/>
			<sup>
				<xsl:value-of select="$noteNBR"/>
			</sup>
		</a>
		<xsl:text> </xsl:text>
	</xsl:template>

	<xsl:template match="tei:note" mode="end">
		<xsl:variable name="noteNBR">
			<xsl:number select="." level="any"/>
		</xsl:variable>
		<p id="{$noteNBR}"><xsl:value-of select="$noteNBR"/>. <xsl:apply-templates/>
			<xsl:text> </xsl:text>
			<a>
				<xsl:attribute name="href"><xsl:text>#back</xsl:text><xsl:value-of select="$noteNBR"
					/></xsl:attribute>
				<xsl:text>Back</xsl:text>
			</a>
		</p>
	</xsl:template>

</xsl:stylesheet>
