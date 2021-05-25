<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ImprimirFactura.aspx.cs" Inherits="OUT_APP_KIOSKOETB.Aplication.Pages.Private.ImprimirFactura" %>

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
    <link rel="stylesheet" href=" https://printjs-4de6.kxcdn.com/print.min.css" />
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

            <div class="row" style="justify-content: center !important; align-items:center !important;">
                <h4 class="text-primary" style="font-family: 'Century Gothic'">Por favor seleccione el periodo de facturación:</h4>
                <div class="col-md-4"></div>
                <div class="col-md-2">

                    <asp:TextBox TextMode="Month" CssClass="form-control" ID="fecha" ClientIDMode="Static" runat="server" OnTextChanged="fecha_TextChanged" AutoPostBack="true"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Seleccione una fecha"
                        ControlToValidate="Fecha" Display="Dynamic" ForeColor="Red" ValidationGroup="Formulario"></asp:RequiredFieldValidator>


                </div>
                <div class="col-md-2">
                    <asp:LinkButton ID="btn_ConsultarFacturaImprimir" CssClass="btn btn-primary btn-md" OnClick="ConsultarFacturaImprimir" OnClientClick="loader();" Visible="false" runat="server" ValidationGroup="Formulario">Consultar</asp:LinkButton>
                </div>
            </div>
            <br />

            <div class="row">
                <div class="col-md-2""></div>
                <div class="col-md-8">
                    <iframe id="fact" runat="server" width="550" height="600" name="whoosh" align="middle" allowscriptaccess="sameDomain" allowfullscreen="false" type="pdf"></iframe>
                </div>
            </div>

            <br />
            <div class="row">
                <asp:LinkButton ID="btn_Atras" CssClass="btn btn-primary btn-md" OnClick="Atras" runat="server"><i class="fas fa-left"></i> Atras</asp:LinkButton>
                <asp:LinkButton ID="btn_Logout" CssClass="btn btn-primary btn-md" OnClick="LogoutUsuario" runat="server"><i class="fas fa-exit"></i> Salir</asp:LinkButton>
            </div>
        </form>
    </div>

    <%--<asp:LinkButton ID="btn_Imprimir" runat="server" onload="printForm()" class="btn btn-primary btn-block ">Imprimir</asp:LinkButton>--%>



    <%-- Archivos JS --%>
    <script src="<% = ResolveClientUrl("~/Content/js/jquery.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/jquery/jquery-ui.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/bootstrap.min.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/jquery.validate.min.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/mdl/material.min.js") %>"></script>
    <script src="https://printjs-4de6.kxcdn.com/print.min.js"></script>
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