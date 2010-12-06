<g:set var="pageTitle" value="${pageProperty(name:'page.pageHeader')}"/>
<g:if test="${!pageTitle}">
	<g:set var="pageTitle" value="Page Title"/>
</g:if>

<!-- Begin Header  -->
<div id="header2">
  <h6>${pageTitle}</h6>
</div>
<!-- End Header  -->
