<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TVG.aspx.cs" Inherits="OrmeAutomation.TVG" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
      <script src="Scripts/jquery-3.4.1.js"></script>
    <script src="Scripts/bootstrap.js"></script>
    <!-- ================== BEGIN core-css ================== -->
	<link href="assets/css/app.min.css" rel="stylesheet" />
	<!-- ================== END core-css ================== -->
	
    <!-- ================== BEGIN core-js ================== -->
	<script src="assets/js/app.min.js"></script>
	<!-- ================== END core-js ================== -->
	
	<!-- ================== BEGIN page-js ================== -->
	<%--<script src="assets/plugins/apexcharts/dist/apexcharts.min.js"></script>
	<script src="assets/js/demo/dashboard.demo.js"></script>--%>
	<!-- ================== END page-js ================== -->
	<link href="assets/plugins/bootstrap-datepicker/dist/css/bootstrap-datepicker.min.css" rel="stylesheet" />
	<link href="assets/plugins/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" />
	<link href="assets/plugins/bootstrap-timepicker/css/bootstrap-timepicker.min.cs" rel="stylesheet" />
</head>
	<body>
  <form runat="server">

        <asp:ScriptManager ID="scriptMngr" runat="server">
           
        </asp:ScriptManager>

 
	    <asp:Timer runat="server" id="UpdateTimer" interval="10000" ontick="UpdateTimer_Tick" />
    <div id="content" >
			<h1 class="page-header mb-3">
				<asp:Label runat="server" ID="lblHead" text="Kat 2 Dokuma Bölümü --Nadir Baca--" />
			</h1>
			
			<!-- BEGIN row -->
			<div class="row">
	<asp:DataList ID="machineView" runat="server" RepeatColumns="5"  RepeatDirection="Horizontal">
        <ItemTemplate>
			
					<!-- BEGIN card -->
        <div class="card text-white-transparent-7 mb-3 overflow-hidden">
           
            <!-- BEGIN card-img-overlay -->
            <div class="card-img-overlay d-none d-md-block rounded" style="background-color:<%# Eval("Status") %>" ></div>
            <!-- END card-img-overlay -->
            <!-- BEGIN card-img-overlay -->
            <!-- END card-img-overlay -->
            <!-- BEGIN card-body -->
            <div class="card-body position-relative">
                <!-- BEGIN row -->
                <div class="row">
                    <!-- BEGIN col-8 -->
                    <div class="col-md-8">
                        <!-- stat-top -->
                        <div class="d-flex">
                            <div class="mr-auto">
                                <h5 class="text-white-transparent-8 mb-1 font-weight-500">Çalışma Süresi</h5>
                                <h3 class="text-white mt-n1 mb-1 font-weight-700"><%# Eval("RunTime") %></h3>
                                <h5 class="text-red mb-1 font-weight-500">Durma Süresi</h5>
                                <h3 class="text-red mt-n1 mb-1 font-weight-700"><%# Eval("StopTime") %></h3>

							</div>
					</div>
				</div>
                    <!-- END col-8 -->
							 <!-- BEGIN col-4 -->
                    <div class="col-md-4 d-none d-md-block" >
                        <div class="mb-2">
                           </span>
                            <asp:Label ID="lblMachName" runat="server" CssClass="fs-24px font-weight-700 btn btn-yellow btn-rounded btn-sm pl-3 pr-3 pt-2 pb-2 " Text='<%# Eval("MachName")%>' /> 
                        </div>
                    </div>
                    <!-- END col-4 -->
			</div>
                <!-- END row -->
				<div class="row d-flex mr-auto">
					                                <h5 class="text-white-transparent-8 mb-1 float-left">&nbsp Verim : &nbsp&nbsp</h5>
                                <h3 class="text-white mt-n1 mb-1 float-right"> <%# Eval("Efficiency") %>%</h3>
</div>
				<div class="progress bg-black mb-2" style="height: 10px;z-index:1;position:relative ">
						<div  style="width:<%# Eval("Efficiency") %>%;background-color:<%# Eval("EffColor") %>;z-index:2;position:relative "></div>
<%--                    <progress value="<%# Eval("Efficiency") %>" max="100" class="bg-white" />--%>
				</div>
                
                                <div class="row">
									                                    
									<div class="col-lg-6 col-md-6">
                                        <h5 class="text-white-transparent-8 mb-1">Kafa</h5>
                                        <h3 class="text-white mt-n1 mb-1"><%# Eval("Head") %></h3>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <h5 class="text-white-transparent-8 mb-1">m/dk</h5>
                                        <h3 class="text-white mt-n1 mb-1"><%# Eval("PrdcSpeed") %></h3>
                                    </div>
                               </div>
				<div>
					<h5 class="text-white-transparent-8 mb-1">Toplam Üretilen</h5>
					<h3 class="text-white mt-n1 mb-1"><%# Eval("Total") %>&nbsp mtr.</h3>
								
                   </div>         
                       


                        <!-- stat-bottom -->


                        
                  
                    

            </div>
            <!-- END card-body -->
        </div>
					<!-- END card -->
			
            </ItemTemplate>
	</asp:DataList>
				<!-- END col-6 -->
				
			
			</div>
			
		</div>

</form>
			<script src="assets/js/app.min.js"></script>
	<!-- ================== END core-js ================== -->
	
	<!-- ================== BEGIN page-js ================== -->
<script src="assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
<script src="assets/plugins/bootstrap-datepicker/js/bootstrap-datepicker.tr.js"></script>
	<script src="assets/plugins/moment/min/moment.min.js"></script>
<script src="assets/plugins/moment/locale/tr.js"></script>
	<script src="assets/plugins/bootstrap-daterangepicker/daterangepicker.js"  charset="UTF-8"></script>
	<script src="assets/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min.js"></script>
	<script src="assets/plugins/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
	<script src="assets/plugins/bootstrap-colorpicker/dist/js/bootstrap-colorpicker.min.js"></script>
	<script src="assets/plugins/bootstrap-tagsinput/dist/bootstrap-tagsinput.min.js"></script>
	<script src="assets/plugins/bootstrap-slider/dist/bootstrap-slider.min.js"></script>
	<script src="assets/plugins/bootstrap-3-typeahead/bootstrap3-typeahead.js"></script>
	<script src="assets/plugins/jquery.maskedinput/src/jquery.maskedinput.js"></script>
	<script src="assets/plugins/pwstrength-bootstrap/dist/pwstrength-bootstrap.min.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/vendor/jquery.ui.widget.js"></script>
	<script src="assets/plugins/blueimp-tmpl/js/tmpl.min.js"></script>
	<script src="assets/plugins/blueimp-load-image/js/load-image.all.min.js"></script>
	<script src="assets/plugins/blueimp-canvas-to-blob/js/canvas-to-blob.min.js"></script>
	<script src="assets/plugins/blueimp-gallery/js/jquery.blueimp-gallery.min.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/jquery.iframe-transport.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/jquery.fileupload.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/jquery.fileupload-process.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/jquery.fileupload-image.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/jquery.fileupload-audio.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/jquery.fileupload-video.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/jquery.fileupload-validate.js"></script>
	<script src="assets/plugins/blueimp-file-upload/js/jquery.fileupload-ui.js"></script>
	<script src="assets/plugins/summernote/dist/summernote.min.js"></script>
	<script src="assets/plugins/summernote/dist/summernote-bs4.min.js"></script>
	<script src="assets/plugins/highlight.js/highlight.min.js"></script>
	<script src="assets/js/demo/highlightjs.demo.js"></script>
	<script src="assets/js/demo/form-plugins.demo.js"></script>
	<!-- ================== END page-js ================== -->
</body>
</html>
