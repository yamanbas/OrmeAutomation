<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WG.aspx.cs" Inherits="OrmeAutomation.WG" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server" >
     <script type="text/javascript">     
         
                $(document).ready(function () {
                    //Mask the textbox as per your format 123-123-123
                    var x = $('#prdcMin');
                    x.mask('99,9', { placeholder: "#" });                   
                });
     </script>	
    <asp:Timer runat="server" id="UpdateTimer" interval="5000" ontick="UpdateTimer_Tick" />
    <div id="content" class="app-content">

			<h1 class="page-header mb-3">
				<asp:Label runat="server" ID="lblHead"  />
			</h1>
			
			<!-- BEGIN row -->
			<div class="row">
	<asp:DataList ID="machineView" runat="server" RepeatColumns="4"  RepeatDirection="Horizontal">
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
                                <h7 class="text-white-transparent-8 mb-1 font-weight-500">Çalışma Süresi</h7>
                                <h5 class="text-white mt-n1 mb-1 font-weight-700"><%# Eval("RunTime") %></h5>
                                <h7 class="text-red mb-1 font-weight-500">Durma Süresi</h7>
                                <h5 class="text-red mt-n1 mb-1 font-weight-700"><%# Eval("StopTime") %></h5>
                                <h7 class="text-white-transparent-8 mb-1">Verimlilik</h7>
                                <h5 class="text-white mt-n1 mb-1"><%# Eval("Efficiency") %>%</h5>

							</div>
					</div>
				</div>
                    <!-- END col-8 -->
							 <!-- BEGIN col-4 -->
                    <div class="col-md-4 d-none d-md-block" >
                        <div class="mb-2">
                           </span>
                            <asp:Button runat="server" ID="buttonPopup" class="fs-16px font-weight-700 btn btn-yellow btn-rounded btn-sm pl-3 pr-3 pt-2 pb-2 " Text='<%# Eval("MachName")%>' OnClick="buttonPopup_Click" ToolTip='<%# Eval("MachId")%>' /> 
                        </div>
                    </div>
                    <!-- END col-4 -->
			</div>
                <!-- END row -->
				<div class="progress bg-black mb-2" style="height: 10px;z-index:1;position:relative ">
						<div  style="width:<%# Eval("Efficiency") %>%;background-color:<%# Eval("EffColor") %>;z-index:2;position:relative "></div>
<%--                    <progress value="<%# Eval("Efficiency") %>" max="100" class="bg-white" />--%>
				</div>
                
                                <div class="row">
									                                    
									<div class="col-lg-6 col-md-6">
                                        <h7 class="text-white-transparent-8 mb-3">Kafa</h7>
                                        <h5 class="text-white mt-n1 mb-1"><%# Eval("Head") %></h5>
                                    </div>
                                    <div class="col-lg-6 col-md-6">
                                        <h7 class="text-white-transparent-8 mb-3">m/dk</h7>
                                        <h5 class="text-white mt-n1 mb-1"><%# Eval("PrdcSpeed") %></h5>
                                    </div>
                               </div>
				<div>
					<h7 class="text-white-transparent-8 mb-1">Toplam Üretilen</h7>
					<h5 class="text-white mt-n1 mb-1"><%# Eval("Total") %>&nbsp mtr.</h5>
								
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
			<!-- END row -->
			<!-- MODAL POPUP -->
           <%--   <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
            <ContentTemplate>   --%>
                <div class="modal fade" id="myModal" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <asp:UpdatePanel ID="upModal" runat="server" ChildrenAsTriggers="false" UpdateMode="Conditional">
            <ContentTemplate>
                <div class="modal-content">
                    <div class="modal-header">
                        
                        <h4 class="modal-title float-left"><asp:Label ID="lblModalTitle" runat="server" Text=""></asp:Label></h4>
                        <button type="button" class="btn btn-default float-lg-right" data-dismiss="modal" aria-hidden="true">X</button>
                    </div>
                    <div class="modal-body row">
                        <div class="col-lg-7">
                            <div class="pb-3">
                        <h5 >Kafa Sayısı: </h5> 
                                </div>
                        <h5>Dakikada Üretim Miktarı :</h5>
                            </div>
                        <div class="col-lg-5">
                            <div class="pb-3">
                          <asp:DropDownList ID="drpdownHeadCount" runat="server" CssClass="form-control">
                            <asp:ListItem Text="1" Value="1"/>
                            <asp:ListItem Text="2" Value="2"/>
                            <asp:ListItem Text="3" Value="3"/>
                            <asp:ListItem Text="4" Value="4"/>
                            <asp:ListItem Text="5" Value="5"/>
                            <asp:ListItem Text="6" Value="6"/>
                            <asp:ListItem Text="7" Value="7"/>
                            <asp:ListItem Text="8" Value="8"/>
                            <asp:ListItem Text="9" Value="9"/>
                            <asp:ListItem Text="10" Value="10"/>
                            <asp:ListItem Text="11" Value="11"/>
                            <asp:ListItem Text="12" Value="12"/>
                            <asp:ListItem Text="13" Value="13"/>
                            <asp:ListItem Text="14" Value="14"/>
                            <asp:ListItem Text="15" Value="15"/>
                            <asp:ListItem Text="16" Value="16"/>
                            <asp:ListItem Text="17" Value="17"/>
                            <asp:ListItem Text="18" Value="18"/>
                            <asp:ListItem Text="19" Value="19"/>
                            <asp:ListItem Text="20" Value="20"/>
                            <asp:ListItem Text="21" Value="21"/>
                            <asp:ListItem Text="22" Value="22"/>
                            <asp:ListItem Text="23" Value="23"/>
                            <asp:ListItem Text="24" Value="24"/>

                         </asp:DropDownList>
                                </div>
                        <asp:TextBox ID="prdcMin" runat="server" CssClass="form-control" ValidateRequestMode="Enabled" />
                        
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:HiddenField ID="hdnMacId" runat="server" />
                        <asp:Button CssClass="btn btn-primary" Text="Kaydet" ID="btnModalSave" runat="server" OnClick="btnModalSave_Click" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</div>
               <%-- </ContentTemplate>
</asp:UpdatePanel>--%>
		</div>
   

</asp:Content>
