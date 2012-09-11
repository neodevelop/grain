<%@ page contentType="text/html"%>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
  <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
  <title>. : Cursos - SynergyJ.com : .</title>
  <!--general stylesheet-->
  <style type="text/css">
  p { padding: 0; margin: 0; }
  h1, h2, h3, p, li { font-family: "Helvetica Neue", Helvetica, Arial, sans-serif; }
  td { vertical-align:top;}
  ul, ol { margin: 0; padding: 0;}
  .title, .date {
    text-shadow: #8aa3c6 0px 1px 0px;
  }

  .textshadow {
    text-shadow: #ffffff 0px 1px 0px;
  }
  .trxtshadow-2 {
    text-shadow: #768296 0px -1px 0px;
  }
  </style>
</head>
<body marginheight="0" topmargin="0" marginwidth="0" leftmargin="0" background="" style="margin: 0px; background-color: #eee; background-image: url(''); background-repeat: repeat;" bgcolor="">
<table cellspacing="0" border="0" cellpadding="0" width="100%" >
  <tbody>
  <tr valign="top">
    <td valign="top"><!--container-->
      <table cellspacing="0" cellpadding="0" border="0" align="center" width="626">
        <tbody>
        <tr>
          <td valign="middle" bgcolor="#546781" height="97"  style="vertical-align: middle;">
            <table cellspacing="0" cellpadding="0" border="0" align="center" width="555" height="97">
              <tbody>
              <tr>
                <td valign="middle" width="36" style="vertical-align:middle; text-align: left;">
                  <img src="${grailsApplication.config.grails.serverURL+'/themes/mail/images/logo.jpg'}"  alt=""  />
                </td>
                <td valign="middle" style="vertical-align: middle; text-align: left;">
                  <h1 class="title" style="margin:0; padding:0; font-size:30px; font-weight: normal; color: #192c45;">
                    <span style="font-weight: bold;">&nbsp;</span>
                  </h1>
                </td>
                <td width="55" valign="middle" style="vertical-align:middle; text-align: center;">
                  <h2 class="date" style="margin:0; padding:0; font-size:13px; font-weight: normal; color: #192c45; text-transform: uppercase; font-weight: bold; line-height:1;">
                    Entrenamiento
                  </h2>
                  <h2 class="date" style="margin:0; padding:0; font-size:23px; font-weight: normal; color: #192c45; font-weight: bold;">
                    <g:formatDate date="${new Date()}" format="yyyy"/>
                  </h2>
                </td>
              </tr>
              </tbody>
            </table>
          </td>
        </tr>
        <tr>
          <td valign="top">
            <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" bgcolor="#ffffff" style="border-width: 3px; border-color: #ffffff; border-style: solid;">
              <tbody>
              <tr>
                <td width="100%" valign="top" bgcolor="#eef0f3" style="border-bottom-width: 3px; border-bottom-color: #ffffff; border-bottom-style: solid;"><!--content-->
                <!--article-->
                  <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%">
                    <tbody>
                    <tr>
                      <td valign="top">
                        <table cellspacing="0" cellpadding="0" border="0" align="center" width="100%">
                          <tbody>
                          <tr>
                            <td height="49" width="100%" valign="middle" bgcolor="#c8cfd8" background="${grailsApplication.config.grails.serverURL+'/themes/mail/images/article-title-bg.jpg'}" style="vertical-align:middle; border-left-width: 1px; border-left-color: #BAC2CC; border-left-style: solid; border-right-width: 1px; border-right-color: #BAC2CC; border-right-style: solid; border-bottom-width: 1px; border-bottom-color: #98a3b4; border-bottom-style: solid; border-top-width: 1px; border-top-color: #BAC2CC; border-top-style: solid;">
                              <h3 class="textshadow" style="margin:0; margin-left: 17px; padding:0; font-size: 18px; font-weight: normal; color:#324258;">
                                Hola <b>${user?.firstName ?: user?.email}</b>, te has inscrito a un curso...
                              </h3>
                            </td>
                          </tr>
                          <tr>
                            <td valign="top" bgcolor="#edeff2" style="padding-top: 20px; padding-bottom: 15px; padding-left: 21px; padding-right: 21px; border-left-width: 1px; border-left-color: #bac2cc; border-left-style: solid; border-right-width: 1px; border-right-color: #bac2cc; border-right-style: solid; border-top-width: 1px; border-top-color: #ffffff; border-top-style: solid; border-bottom-width: 3px; border-bottom-color: #ffffff; border-bottom-style: solid;">
                              <table cellspacing="0" cellpadding="0" border="0" align="left" width="190">
                                <tr>
                                  <td valign="top" style="padding-right: 20px;">
                                    <img width="164" height="164" src="
                                    ${grailsApplication.config.grails.serverURL+'/themes/mail/images/register.jpg'}" alt="istockphoto" align="left" style="border-width: 3px; border-style: solid; border-color: #ffffff;" />
                                  </td>
                                </tr>
                              </table>
                              <p style="font-size: 12px; line-height: 20px; font-weight: normal; color: #56667d; margin: 0; margin-bottom: 10px;">
                                Te has inscrito al curso <b>${courseName ?: "!!!"}</b>
                              </p>
                              <p style="font-size: 12px; line-height: 20px; font-weight: normal; color: #56667d; margin: 0; margin-bottom: 10px;">
                                Las sesiones de este curso son:
                                <ul style="font-size: 12px; line-height: 20px; font-weight: normal; color: #56667d; margin: 0; margin-bottom: 10px; padding-left:230px;">
                                  <g:each in="${scheduledCourse?.courseSessions?.sort()}" var="courseSession">
                                    <li><g:formatDate date="${courseSession?.sessionStartTime}" format="EEEE dd 'de' MMMM 'del' yyyy" locale="es"/></li>
                                  </g:each>
                                </ul>
                              </p>
                              <p style="font-size: 12px; line-height: 20px; font-weight: normal; color: #56667d; margin: 0; margin-bottom: 10px;">
                                Con un horario de 9:00 a 18:00 hrs.
                              </p>
                              <p style="font-size: 12px; line-height: 20px; font-weight: normal; color: #56667d; margin: 0; margin-bottom: 10px;">
                                Por favor, ingresa a nuestro portal para escoger la forma de pago que mejor te convenga.
                                <div align="center" style="font-size: 12px; font-weight: normal; color: #56667d; margin: 0; margin-bottom: 10px;">
                                  <a href="${grailsApplication.config.grails.serverURL+'/login'}">
                                    ${grailsApplication.config.grails.serverURL+'/login'}
                                  </a>
                                </div>
                              </p>
                              <p style="font-size: 12px; line-height: 20px; font-weight: normal; color: #56667d; margin: 0; margin-bottom: 10px;">
                                Agradecemos de antemano tu preferencia y nos reiteramos a tus apreciables órdenes...
                              </p>
                              <p align="center" style="font-size: 12px; line-height: 20px; font-weight: normal; color: #56667d; margin: 0; margin-bottom: 10px;">
                                <b>ATENTAMENTE</b><br/>
                                <b>Staff de SynergyJ.com</b>
                              </p>
                            </td>
                          </tr>
                          </tbody>
                        </table>
                      </td>
                    </tr>
                    </tbody>
                    <!-- /article--></table>
                </td><!--/content-->
              </tr>
              <tr>
                <td colspan="2" valign="middle" height="50" bgcolor="#e7eaee" style="vertical-align:middle; border-width: 1px; border-style: solid; border-color: #b6bec9; text-align: center;">
                  <p style="margin:0; font-size: 10px; font-weight: bold; color: #96a2b3; font-family: Arial; line-height: 18px;">
                    No es necesario responder este correo. <br />
                  </p>
                  <p style="margin:0; font-size: 10px; font-weight: bold; color: #96a2b3; font-family: Arial; line-height: 18px;">
                    SynergyJ.com. Para contacto directo puedes escribirnos a: <unsubscribe style="color: #455670; text-decoration: underline;">cursos@synergyj.com</unsubscribe>
                  </p>
                </td>
              </tr>
              </tbody>
            </table>
          </td>
        </tr>
        </tbody>
      </table><!--/container-->
    </td>
  </tr>
  </tbody>
</table>
</body>
</html>