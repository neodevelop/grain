  <g:form name="fileuploadForm" controller="payment" action="fileupload" method="POST" enctype="multipart/form-data" style="display:none;" class="well form-horizontal">
    <fieldset>
      <g:hiddenField name="paymentNumber" value=""/>
      <div class="control-group">
        <label class="control-label">Archivo:</label>
        <input id="file" type="file" name="file" class="file"/>
      </div>
      <div class="control-group">
        <label class="control-label"></label>
        <input value=". : Subir archivo : ." class="btn btn-success" type="submit" id="sendReceipt">
      </div>
      <div class="progress progress-striped active" id="loaderProgressBar" style="display: none;">
        <div style="width: 100%" class="bar"></div>
      </div>
    </fieldset>
  </g:form>