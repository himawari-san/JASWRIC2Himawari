<?xml version="1.0" encoding="utf-8"?>
<!--
  jaswric.xsl
  Written by Masaya YAMAGUCHI
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- 表示用 -->

  <xsl:template match="composition">
    <html xmlns:xhtml="http://www.w3.org/1999/xhtml" lang="ja">
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta http-equiv="Content-Style-Type" content="text/css" />
        <link rel="stylesheet" href="jaswric.css" type="text/css" />
	<title>
		<xsl:value-of select="@topic"/>
		<xsl:text>：</xsl:text>
		<xsl:value-of select="@writer"/>
	</title>
      </head>

      <body>
        <h1>
	  <xsl:value-of select="@topic"/>
	  <xsl:text>：</xsl:text>
	  <xsl:value-of select="@writer"/>
        </h1>
	<hr />
	<ul class="metainfo">
	  <li>個人コード：<xsl:value-of select="@writer" /></li>
	  <li>学年：<xsl:value-of select="@grade" /></li>
	  <li>学年コード：<xsl:value-of select="@grade_code" /></li>
	  <li>読書志向（G7以外）：<xsl:value-of select="@read" /></li>
	  <li>作文志向（G7以外）：<xsl:value-of select="@write" /></li>
	  <li>年齢（G13のみ）：<xsl:value-of select="@age" /></li>
	  <li>共通テスト国語現代文スコア（G13のみ）：<xsl:value-of select="@score" /></li>
	</ul>
	<img class="handwriting">
	  <xsl:attribute name="src">
	    <xsl:value-of select="img/@src"/>
	  </xsl:attribute>
	</img>
	<hr style="clear: both;" />

	
        <xsl:apply-templates/>
	<!-- reffer to http://www.feedthebot.com/pagespeed/defer-loading-javascript.html -->
	<script type="text/javascript">
	  function downloadJSAtOnload() {location.href="#himawari";}
	  if (window.addEventListener)
	  window.addEventListener("load", downloadJSAtOnload, false);
	  else if (window.attachEvent)
	  window.attachEvent("onload", downloadJSAtOnload);
	  else window.onload = downloadJSAtOnload;
	</script>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="s">
    <p>
      <xsl:apply-templates/>
    </p>
  </xsl:template>

  <xsl:template match="m[@p!='']">
    <span class="su">
      <xsl:attribute name="title">
	<xsl:if test="@p">
	  <xsl:text>品詞: </xsl:text>
  	  <xsl:value-of select="@j"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@k != ''">
	  <xsl:text>活用型: </xsl:text>
  	  <xsl:value-of select="@k"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@j != ''">
	  <xsl:text>活用形: </xsl:text>
  	  <xsl:value-of select="@j"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@h != ''">
	  <xsl:text>語彙素: </xsl:text>
  	  <xsl:value-of select="@h"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@i != ''">
	  <xsl:text>語彙素読み: </xsl:text>
  	  <xsl:value-of select="@i"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@m != ''">
	  <xsl:text>発音形出現形: </xsl:text>
  	  <xsl:value-of select="@m"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@n != ''">
	  <xsl:text>仮名形出現形: </xsl:text>
  	  <xsl:value-of select="@n"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@o != ''">
	  <xsl:text>語種: </xsl:text>
  	  <xsl:value-of select="@o"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@p != ''">
	  <xsl:text>書字形(基本形): </xsl:text>
  	  <xsl:value-of select="@p"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
	<xsl:if test="@q != ''">
	  <xsl:text>語形(基本形): </xsl:text>
  	  <xsl:value-of select="@q"/>
	  <xsl:text>&#10;</xsl:text>
	</xsl:if>
      </xsl:attribute>

      <xsl:apply-templates/>

    </span>
    <xsl:text>/</xsl:text>
  </xsl:template>


  <xsl:template match="tg">
    <span class="target_char">
      <xsl:attribute name="id">
        <xsl:value-of select="@id"/>
      </xsl:attribute>
      <xsl:apply-templates/>
    </span>
  </xsl:template>

</xsl:stylesheet>
