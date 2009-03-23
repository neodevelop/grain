<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<title>Grain - [<g:layoutTitle default="" />]</title>
	<link rel="stylesheet" href="${createLinkTo(dir:'themes/synergyj',file:'style.css')}" />
	<link rel="shortcut icon" href="${createLinkTo(dir:'themes/synergyj',file:'favicon.ico')}" type="image/x-icon" />
	<g:javascript library="prototype"/>
	<g:javascript library="application" />
	<g:layoutHead />
	
</head>

<body>
	<g:render template="/common/top" />
	
	<!--body start -->
	<div id="body">

		<g:render template="/common/menuHorizontal" />

		<!--left panel start -->
		<div id="container">
			<g:if test="${flash.message}">
            	<div class="message"><g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}" /></div>
            </g:if>
			<g:layoutBody />	
			<br class="spacer" />
		</div>

		<g:render template="/common/news" />
		
		<g:render template="/common/bodyBottom" />
		
		<br class="spacer" />
	</div>
	<!--body end -->
	
	<g:render template="/common/footer" />

</body>
</html>
