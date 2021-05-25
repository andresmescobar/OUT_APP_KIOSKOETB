<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UltimaFactura.aspx.cs" Inherits="OUT_APP_KIOSKOETB.Aplication.Pages.Private.UltimaFactura" %>

<%
    Response.Cache.SetCacheability(HttpCacheability.NoCache);
    Response.Cache.AppendCacheExtension("no-store, must-revalidate");
    Response.AppendHeader("Pragma", "no-cache");
    Response.AppendHeader("Expires", "0");
    Response.Headers.Remove("Cache-Control");
    Response.AppendHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="es-co">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="author" content="Outsourcing SA" />
    <meta name="country" content="COL" />
    <meta name="currency" content="$" />

    <meta http-equiv="Expires" content="0" />
    <meta http-equiv="Last-Modified" content="0" />
    <meta http-equiv="Cache-Control" content="no-cache, mustrevalidate" />
    <meta http-equiv="Pragma" content="no-cache" />

    <title>Kiosco Autogestión - ETB</title>

    <link rel="shortcut icon" type="image/x-icon" href="<% = ResolveClientUrl("~/Content/images/favicon.ico") %>" />
    <link href="<% = ResolveClientUrl("~/Content/images/favicon.ico") %>" rel="apple-touch-icon" />
    <link href="<% = ResolveClientUrl("~/Content/css/bootstrap.min.css") %>" rel="stylesheet" />
    <link href="<% = ResolveClientUrl("~/Content/font-awesome/css/font-awesome.css") %>" rel="stylesheet" />

    <link href="<% = ResolveClientUrl("~/Content/css/Inicio.css") %>" rel="stylesheet" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons" />
    <link href="<% = ResolveClientUrl("~/Content/mdl/material.min.css") %>" rel="stylesheet" />
    <link href="<% = ResolveClientUrl("~/Content/css/loader.css") %>" rel="stylesheet" />
    <script src="<%=ResolveClientUrl("~/Content/js/SweetAlert.js")%>"></script>

</head>
<body class="full">
    <div id="S_Up" class="ir-arriba fa fa-chevron-up" title="Ir arriba" style="display: none;"></div>

    <div class="page-container">
        <form id="generalForm" runat="server" autocomplete="off" class="form-login">
            <div id="headerFull">
                <a href="<% = ResolveClientUrl("~/Aplication/Pages/Public/Default.aspx") %>">
                    <img src="<% = ResolveClientUrl("~/Content/images/logoetb.png") %>" style="max-width: 330px;" title="ETB" />
                </a>
            </div>

            <div class="row">
                <h4 class="text-primary" style="font-family: 'Century Gothic'">Última facturación generada:</h4>
                <div class="col-md-2"></div>
                <div class="col-md-4">
                    <div class="col-md-6 col-sm-12"">
                        <h4 class="text-primary" style="font-family: 'Century Gothic'">Información de la facturación</h4>
                    </div>
                    <div class="form-group col-md-6 col-sm-12"">
                        <asp:Label Text="Período Facturado" runat="server" />
                        <asp:TextBox ID="txb_PeriodoFacturado" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>                        
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Cuenta de facturación" runat="server" />
                        <asp:TextBox ID="txb_CuentaDeFacturacion" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Dirección de Facturación" runat="server" />
                        <asp:TextBox ID="txb_DireccionDeFacturacion" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Fecha límite de Facturación" runat="server" />
                        <asp:TextBox ID="txb_FechaLimiteDeFacturacion" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Número de facturación" runat="server" />
                        <asp:TextBox ID="txb_NumeroDeFacturacion" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Tipo de entrega" runat="server" />
                        <asp:TextBox ID="txb_TipoDeEntrega" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Correo electronico" runat="server" />
                        <asp:TextBox ID="txb_CorreoElectronico" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Fecha límite de pago" runat="server" />
                        <asp:TextBox ID="txb_FechaLimiteDePago" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="form-group col-md-6 col-sm-12">
                        <h4 class="text-primary" style="font-family: 'Century Gothic'">Información del pago</h4>
                    </div>
                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Banco" runat="server" />
                        <asp:TextBox ID="txb_Banco" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Fecha de pago" runat="server" />
                        <asp:TextBox ID="txb_FechaDePago" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Tipo de pago" runat="server" />
                        <asp:TextBox ID="txb_TipoDePago" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>

                    <div class="form-group col-md-6 col-sm-12">
                        <asp:Label Text="Valor" runat="server" />
                        <asp:TextBox ID="txb_Valor" type="text" Enabled="false" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                </div>
            </div>

            <br />
            <div class="row">
                <asp:LinkButton ID="btn_Atras" CssClass="btn btn-primary btn-md" OnClick="Atras" runat="server"><i class="fas fa-left"></i> Atras</asp:LinkButton>
                <asp:LinkButton ID="btn_Logout" CssClass="btn btn-primary btn-md" OnClick="LogoutUsuario" runat="server"><i class="fas fa-exit"></i> Salir</asp:LinkButton>
            </div>
        </form>
    </div>

    
    <%-- Archivos JS --%>
    <script src="<% = ResolveClientUrl("~/Content/js/jquery.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/jquery/jquery-ui.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/bootstrap.min.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/jquery.validate.min.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/mdl/material.min.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/Inicio.js") %>"></script>
</body>
</html>