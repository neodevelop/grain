<g:if test="${flash.error}">
<div id="appError" style="display: none;">
  ${flash.error}
</div>
<script language="javascript">
  $("div#appError").fadeIn().delay(4000).fadeOut();
</script>
</g:if>