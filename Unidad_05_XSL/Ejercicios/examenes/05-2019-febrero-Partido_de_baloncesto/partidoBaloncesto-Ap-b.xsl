<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="iso-8859-1"/>

  <xsl:template match="/partidoBaloncesto">
    <html>
      <head>
        <title>Partido Ap B</title>
      </head>
      <body>
        <table width="90%" border="1" align="center"
          style="background-image: url('{pista}')">
          <xsl:call-template name="bucleForFila">
            <xsl:with-param name="i">1</xsl:with-param>
          </xsl:call-template>
        </table>
        
        <p></p>
        
        <table width="90%" border="1" align="center">
          <tr>
            <th>Tiempo</th>
            <th>Jugador</th>
            <th>Apodo</th>
            <th>Imagen</th>
            <th>Descripción</th>
          </tr>
          <xsl:for-each select="historico/entrada">
            <tr>
              <td><xsl:value-of select="@tiempo"/></td>
              <td><xsl:value-of select="@jugador"/></td>
              <td>
                <xsl:variable name="nombreJugador"><xsl:value-of select="@jugador"/></xsl:variable>
                <xsl:value-of select="/partidoBaloncesto/equipo/jugador[@nombre = $nombreJugador]/@apodo"/>
              </td>
              <td>
                <xsl:variable name="tipoEntrada"><xsl:value-of select="@tipo"/></xsl:variable>
                <img width="30px" src="{/partidoBaloncesto/historico/imagen[@tipo = $tipoEntrada]}"/>
              </td>
              <td><xsl:value-of select="."/></td>
            </tr>
          </xsl:for-each>
        </table>
        
      </body>
    </html>
  </xsl:template>


  <xsl:template name="bucleForFila">
    <xsl:param name="i"/>
    <xsl:if test="$i &lt;= 5">
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
    <xsl:if test="$j &lt;= 10">
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
    <td>
      <xsl:for-each select="equipo/jugador">
        <xsl:if test="@posicionX = $x and @posicionY = $y">
          <img src="{../@imagen}" width="30px"/>
          <xsl:value-of select="@nombre"/>
        </xsl:if>
      </xsl:for-each>
    </td>
  </xsl:template>
  

</xsl:stylesheet>
