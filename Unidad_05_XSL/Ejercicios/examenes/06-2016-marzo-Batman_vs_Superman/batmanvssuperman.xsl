<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="iso-8859-1"/>

  <xsl:template match="/cine">
    <html>
      <head>
        <title>Cine <xsl:value-of select="@nombre"/></title>
      </head>
      <body>
        <xsl:apply-templates select="titulo"/>
        <xsl:apply-templates select="sesiones"/>
        <xsl:apply-templates select="cartelera"/>
      </body>
    </html>
  </xsl:template>

  <!-- -->
  <xsl:template match="titulo">
    <h1>Cine: <xsl:value-of select="@nombre"/></h1>
    <table border="1" align="center" width="80%">
      <tr>
        <td rowspan="2"><img src="{imagen}" width="100px"/></td>
        <td><xsl:value-of select="@nombre"/></td>
      </tr>
      <tr>
        <td>Fecha de estreno: 
          <xsl:value-of select="@estreno"/></td>
      </tr>
    </table>
  </xsl:template>

  <!-- -->
  <xsl:template match="sesiones">
    <h1>Sesiones</h1>
    
    <table width="90%" border="1" align="center">
      <xsl:for-each select="sesion">
        <tr>
          <xsl:if test="position() mod 2 = 1">
            <xsl:attribute name="style">
              background: lightblue;
            </xsl:attribute>
          </xsl:if>
          <td align="center">
            Sesión: <xsl:value-of select="@hora"/>
          
            <table width="70%" align="center" border="1">
              <xsl:call-template name="bucleForFila">
                <xsl:with-param name="i">1</xsl:with-param>
              </xsl:call-template>
            </table>
          </td>
        </tr>        
      </xsl:for-each>
    </table>
  </xsl:template>


  <xsl:template name="bucleForFila">
    <xsl:param name="i"/>
    <xsl:if test="$i &lt;= 4">
      <tr>
        <xsl:call-template name="bucleForColumna">
          <xsl:with-param name="i"><xsl:value-of select="$i"/></xsl:with-param>
          <xsl:with-param name="j">1</xsl:with-param>
        </xsl:call-template>
      </tr>
      <xsl:call-template name="bucleForFila">
        <xsl:with-param name="i"><xsl:value-of select="$i + 1"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  
  <xsl:template name="bucleForColumna">
    <xsl:param name="i"/>
    <xsl:param name="j"/> 
    <xsl:if test="$j &lt;= 4">
      <xsl:call-template name="celda">
        <xsl:with-param name="x"><xsl:value-of select="$j"/></xsl:with-param>
        <xsl:with-param name="y"><xsl:value-of select="$i"/></xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="bucleForColumna">
        <xsl:with-param name="i"><xsl:value-of select="$i"/></xsl:with-param>
        <xsl:with-param name="j"><xsl:value-of select="$j + 1"/></xsl:with-param>
      </xsl:call-template>
    </xsl:if>
  </xsl:template>
  
  
  <xsl:template name="celda">
    <xsl:param name="x"/>
    <xsl:param name="y"/>
    <td align="center">
      <xsl:choose>
        <xsl:when test="ocupado[$x = @asiento and $y = @fila]">
          <img width="30px" src="{/cine/imagenes/imagen[@id = 'ocupado']}"/>
        </xsl:when>
        <xsl:otherwise>
          <img width="30px" src="{/cine/imagenes/imagen[@id = 'libre']}"/>
        </xsl:otherwise>
      </xsl:choose>
    </td>
  </xsl:template>
  
  <!-- -->
  <xsl:template match="cartelera">
    <h1>Cartelera</h1>
    <table width="80%" border="1" align="center">
      <xsl:for-each select="pelicula">
        <tr>
          <td>
            <xsl:variable name="idPeli"><xsl:value-of select="@id"/></xsl:variable>
            <img width="50px" src="{/cine/imagenes/imagen[@id = $idPeli]}"/>
          </td>
          <td><xsl:value-of select="@nombre"/></td>
        </tr>
      </xsl:for-each>
    </table>
  </xsl:template>
  
</xsl:stylesheet>





