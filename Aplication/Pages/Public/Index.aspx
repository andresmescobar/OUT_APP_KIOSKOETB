<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="OUT_APP_KIOSKOETB.Aplication.Pages.Public.Index" %>

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

    <style>
        .buttonIngresar {
            font-family: 'Century Gothic';
            display: none;
            margin-right: 20px;
            margin-top: 15px;
            width: 210px !important;
            height: 70px !important;
            font-size: 30px !important;
        }
    </style>

</head>
<body class="full">
    <div id="S_Up" class="ir-arriba fa fa-chevron-up" title="Ir arriba" style="display: none;"></div>

    <div class="page-container">
        <form id="generalForm" runat="server" autocomplete="off" class="form-login">
            <div id="headerFull">
                <img src="<% = ResolveClientUrl("~/Content/images/logoetb.png") %>" style="max-width: 330px;" title="ETB" />
            </div>

            <h4 class="text-primary" style="font-family: 'Century Gothic'">Por favor digite su número de telefono</h4>
            <div class="form-group">
                <center>
                    <asp:TextBox ID="document" type="number" CssClass="form-control onlyNumber" MinLength="7" MaxLength="15" ClientIDMode="Static" runat="server"></asp:TextBox>
                </center>
            </div>
            <div id="dEscudo"></div>
            <div style="margin-top: 45px;">
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('1');" autofocus>1</button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('2');">2</button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('3');">3</button>
            </div>
            <br />
            <div>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('4');">4</button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('5');">5</button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('6');">6</button>
            </div>
            <br />
            <div>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('7');">7</button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('8');">8</button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('9');">9</button>
            </div>
            <br />
            <div>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect btnNumbers btn-warning" onclick="delAll();"><span class="fa fa-times fa-lg"></span></button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect btnNumbers" style="font-family: 'Century Gothic'" onclick="escribirNumero('0');">0</button>
                <button class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect btnNumbers" onclick="delLastNumber();"><span class="fa fa-arrow-left"></span></button>
            </div>
            <div>
                <asp:Button ID="btn_Consult" CssClass="btn btn-primary btn-md buttonIngresar" Text="Ingresar" OnClick="btn_Consult_Click" OnClientClick="loader();" UseSubmitBehavior="False" runat="server" ClientIDMode="Static" />
            </div>
        </form>
    </div>
    <div class="alert alert-warning alert-dismissable alertMessage" id="WarnigAlert">
        <button type="button" class="close" title="Cerrar mensaje" onclick="CloseAlert('W');">&times;</button>
        <p id="Mensaje_Warnig">
            <strong>¡Atención!</strong><br />
            Es muy importante que leas este mensaje de alerta.
        </p>
    </div>

    <div class="alert alert-danger alert-dismissable alertMessage" id="ErrorAlert">
        <button type="button" class="close" title="Cerrar mensaje" onclick="CloseAlert('E');">&times;</button>
        <p id="Mensaje_Error">
            <strong>¡Cuidado!</strong><br />
            Es muy importante que leas este mensaje de peligro.
        </p>
    </div>

    <div class="alert alert-success alert-dismissable alertMessage" id="SuccessAlert">
        <button type="button" class="close" title="Cerrar mensaje" onclick="CloseAlert('S');">&times;</button>
        <p id="Mensaje_Success">
            <strong>¡Completado!</strong><br />
            Es muy importante que leas este mensaje de acción completada.
        </p>
    </div>

    <div class="alert alert-info alert-dismissable alertMessage" id="InfoAlert">
        <button type="button" class="close" title="Cerrar mensaje" onclick="CloseAlert('I');">&times;</button>
        <p id="Mensaje_Info">
            <strong>¡información!</strong><br />
            Este es un mensaje de información.
        </p>
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
                showConfirmButton: false,
            });
        }
    </script>
</body>
</html>

