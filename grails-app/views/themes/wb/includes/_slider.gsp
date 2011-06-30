<!-- Begin Header  -->
<div id="header"><div id="slider">
			<ul>
        <% (1..10).each{ num ->  %>
				<li><a href="#"><img src="${createLinkTo(dir:'themes/wb/images',file:'header'+num+'.jpg')}" alt="" border="0" /></a></li>
        <% } %>
			</ul>
  </div></div>
<!-- End Header  -->
