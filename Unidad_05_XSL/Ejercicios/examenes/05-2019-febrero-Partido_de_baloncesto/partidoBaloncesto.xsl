<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="iso-8859-1"/>

  <xsl:template match="/partidoBaloncesto">
    <html>
      <head>
        <title>Partido baloncesto</title>
        <xsl:call-template name="css"/>
      </head>
      <body>
        <table align="center" border="1" width="80%">
          <tr>
            <th>Imagen</th>
            <th>Nombre</th>
            <th>Dorsal</th>
            <th>Apodo</th>
            <th>Puntos</th>
            <th>Rebotes</th>
            <th>Asistencias</th>
          </tr>     
          <xsl:apply-templates select="equipo"/>
        </table>
      </body>
    </html>
  </xsl:template>
  
  <!--  -->
  <xsl:template match="equipo">
    <xsl:choose>
      <xsl:when test="@tipo = 'Local'">
        <xsl:call-template name="tablaEquipo">
          <xsl:with-param name="colorEquipo">lightBlue</xsl:with-param>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="tablaEquipo">
          <xsl:with-param name="colorEquipo">lightGreen</xsl:with-param>
        </xsl:call-template>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template name="css">
    <style type="text/css">
      th {
        background: blue;
        color: white;
      }
      .icono {
        width: 35px;
      }
    </style>
  </xsl:template>
  
  
  <!--  -->
  <xsl:template name="tablaEquipo">
    <xsl:param name="colorEquipo"/>
    
    <xsl:for-each select="jugador">
      <xsl:sort select="@nombre" order="ascending"/>
        <tr>
          <xsl:if test="position() mod 2 = 1">
            <xsl:attribute name="style">
              background:<xsl:value-of select="$colorEquipo"/>
            </xsl:attribute>
          </xsl:if>
          <td><img class="icono" src="{../@imagen}"/></td>
          <td><xsl:value-of select="@nombre"/></td>
          <td><xsl:value-of select="@dorsal"/></td>
          <td><xsl:value-of select="@apodo"/></td>
          <td><xsl:value-of select="@puntos"/></td>
          <td><xsl:value-of select="@rebotes"/></td>
          <td><xsl:value-of select="@asistencias"/></td>
        </tr>     
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>












