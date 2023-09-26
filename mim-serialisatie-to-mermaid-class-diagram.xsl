<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:UML="omg.org/UML1.3"
    xmlns:mim="http://www.geostandaarden.nl/mim/informatiemodel/v1"
    xmlns:mim-ext="http://www.geostandaarden.nl/mim-ext/informatiemodel/v1"
    xmlns:mim-ref="http://www.geostandaarden.nl/mim-ref/informatiemodel/v1"
    exclude-result-prefixes="xs" version="2.0">

    <xsl:output method="text" indent="yes" omit-xml-declaration="yes"/>

    <xsl:strip-space elements="*"/>    
        
    <!-- identity copy, kopieert default alles naar de output (tenzij er een aparte template voor is)-->
    <xsl:template match="*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates select="* | comment() | text()"/>
        </xsl:copy>
    </xsl:template>
    <!--identity copy voor attributen-->
    <xsl:template match="@*">
        <xsl:copy-of select="."/>
    </xsl:template>
        
    <xsl:template match="mim:Informatiemodel">
    classDiagram
    <xsl:apply-templates select="*"/>
    </xsl:template>    

    <xsl:template match="mim:packages">
        <xsl:apply-templates select="mim:Domein/mim:objecttypen/mim:Objecttype"></xsl:apply-templates>        
    </xsl:template>
    
    <xsl:template match="mim:Domein/mim:objecttypen/mim:Objecttype">
        
        class <xsl:value-of select="mim:naam"/> {
            <xsl:for-each select="mim:attribuutsoorten/mim:Attribuutsoort">
                + <xsl:value-of select="mim:naam"/>                
            </xsl:for-each>
        }
        click <xsl:value-of select="mim:naam"/> href "<xsl:value-of select="mim:begrip"/>" "Begrip"
        
        <xsl:for-each select="mim:supertypen/mim:GeneralisatieObjecttypen/mim:supertype">
            <xsl:value-of select="../../../mim:naam"/> --|> <xsl:value-of select="mim-ref:ObjecttypeRef"/><xsl:value-of select="mim-ext:ConstructieRef"/><xsl:text>&#xa;</xsl:text>
            
        </xsl:for-each>
        <xsl:for-each select="mim:relatiesoorten/mim:Relatiesoort">
            <xsl:value-of select="../../mim:naam"/> "<xsl:value-of select="mim:relatierollen/mim:Bron/mim:kardinaliteit"/>" --<xsl:text>></xsl:text> "<xsl:value-of select="mim:relatierollen/mim:Doel/mim:kardinaliteit"/>" <xsl:value-of select="mim:doel/mim-ref:ObjecttypeRef"/> : <xsl:value-of select="mim:naam"/><xsl:text>&#xa;</xsl:text>               
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="mim:packages/mim:Domein">       
    </xsl:template>
         
    <xsl:template match="mim:naam|
                         mim:definitie|
                         mim:herkomst|
                         mim:informatiemodeltype|
                         mim:informatiedomein|
                         mim:relatiemodelleringtype|                                          
                         mim:MIMVersie|
                         mim-ext:kenmerken|
                         mim:Extern">    
    </xsl:template>
</xsl:stylesheet>
