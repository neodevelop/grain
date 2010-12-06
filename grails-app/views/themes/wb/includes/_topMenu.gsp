<g:set var="options" value="${menu.options(name:'top')}"/>

<!-- Begin Top Bar  -->
<div id="topbar">
  <g:if test="${options}">

    <!-- Begin LavaLamp Navigation  -->
    <div id="nav">
      <ul class="lavaLampWithImage" id="1">
        <g:each in="${options}" var="option">
          <li><a href="index.html">${option.item.labelCode}</a></li>
        </g:each>
      <%--
      <li class="current"><a href="index.html">Home</a></li>
      <li><a href="about.html">About</a></li>
      <li><a href="services.html">Services</a></li>
      <li><a href="events.html">Events</a></li>
      <li><a href="contacts.html">Contacts</a></li>
      --%>
      </ul>
    </div>
    <!-- End LavaLamp Navigation  -->

  </g:if>
</div>
<!-- End Top Bar  -->