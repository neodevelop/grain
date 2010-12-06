<g:set var="options" value="${menu.options(name:'top')}"/>

<!-- Begin Top Bar  -->
<div id="topbar">
  <g:if test="${options}">

    <!-- Begin LavaLamp Navigation  -->
    <div id="nav">
      <ul class="lavaLampWithImage" id="1">
        <g:each in="${options}" var="option">
          <li><a href="${menu.link(option:option)}">${g.message(code:option.item.labelCode, default:option.item.labelCode)}</a></li>
        </g:each>
      </ul>
    </div>
    <!-- End LavaLamp Navigation  -->

  </g:if>
</div>
<!-- End Top Bar  -->