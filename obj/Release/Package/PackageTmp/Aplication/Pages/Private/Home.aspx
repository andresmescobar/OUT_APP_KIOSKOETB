<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="OUT_APP_KIOSKOETB.Aplication.Pages.Private.Home" %>

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
                <img src="<% = ResolveClientUrl("~/Content/images/logoetb.png") %>" style="max-width: 330px;" title="ETB" />
            </div>

            <div class="row">
                <h3 style="margin-bottom: 30px;">Bienvenido al Kiosco de Autogestión de <b style="color: #274683;">ETB</b>.</h3>
                <div class="col-md-6">
                    <asp:LinkButton ID="btn_Ultima" CssClass="btn btn_menu" OnClick="UltimaFacturas" OnClientClick="loader();" runat="server">Última <br /> Factura</asp:LinkButton>
                </div>
                <div class="col-md-6">
                    <asp:LinkButton ID="btn_Con" CssClass="btn btn_menu" OnClick="ConsultarFacturas" OnClientClick="loader();" runat="server">Consultar <br /> Facturas</asp:LinkButton>                    
                </div>
            </div>
            <br />
            <div class="row" style="margin-top: 100px;">
                <asp:LinkButton ID="btn_LogoutHome" CssClass="btn btn-primary btn-md" OnClick="LogoutUsuario" runat="server">Salir</asp:LinkButton>
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

    <script type="text/javascript">
        function loader() {
            swal.fire({
                title: 'Por Favor Espera',
                text: 'En este momento se esta validando los datos, una vez finalice se mostrará las opciones',
                icon: 'success',
                allowOutsideClick: false,
                allowEscapeKey: false,
                allowEnterKey: false,
                showConfirmButton: false
            });
        }
    </script>
</body>
</html>