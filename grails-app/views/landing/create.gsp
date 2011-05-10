<html>
<head>
  <title>Registro al curso</title>
  <script type="text/javascript" src="http://localhost:8080/grain/plugins/jquery-1.6/js/jquery/jquery-1.6.js"></script>
  <script type="text/javascript" src="http://jquery.bassistance.de/validate/jquery.validate.js"></script>
  <script type="text/javascript">
    $(function(){
      $("form#registration").submit(function(){
        var form = $(this);
        console.log(form);
        $.ajax({
          type:'POST',
          url:form.attr("action"),
          data:form.serialize(),
          dataType:"json",
          success:function(json){ console.log(json); },
          error:function(xhr){ console.log(xhr); }
        });
        return false;
      });
    });
  </script>
</head>
<body>
<form id="registration" action="http://localhost:8080/grain/addMeFromLanding" method="POST">

  <ul>
    <li>
      <label for="email">E-m@il:</label>
      <input type="text" id="email" name="email" value=""/>
    </li>
    <li>
      <label for="password">Password:</label>
      <input type="password" maxlength="200" id="password" name="password" value=""/>
    </li>
    <li>
      <label for="confirmPassword">Confirmar password:</label>
      <input type="password" maxlength="200" id="confirmPassword" name="confirmPassword" value=""/>
    </li>
    <li>
      <div class="submit">
        <input class="sendButton" name="sendButton" type="submit" value="Registrarme!!!"/>
      </div>
    </li>
  </ul>

</form>
<a id="reg" href="http://localhost:8080/grain/registration/addMeFromLanding">Presioname...</a>
</body>
</html>