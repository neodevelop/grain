<g:set var="options" value="${menu.options(name:'bottom')}"/>

<!-- Begin Footer2  -->
<div id="footer2">
  <div id="footer2content">
    <div style="width:300px; float:left;"><content:body key="copyright"/></div>
    <div style="width:400px; float:right; text-align: right;">
      <g:each in="${options}" var="option">
        •  <a href="${menu.link(option: option)}">${g.message(code: option.item.labelCode, default: option.item.labelCode)}</a>
      </g:each>
    </div>
  </div>
</div>
<!-- End Footer2  -->