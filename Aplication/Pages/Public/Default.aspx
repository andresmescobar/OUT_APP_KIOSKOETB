<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OUT_APP_KIOSKOETB.Aplication.Pages.Public.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml" lang="es-co" onkeypress="Goto();" onclick="Goto();" onmouseover="Goto();">
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
    <style>
        html {
            -ms-user-select: none;
            user-select: none;
            cursor: pointer !important;
            cursor: hand !important;
        }

        body {
            background: #f8f8f8;
            background-color: rgba(253, 253, 253, 0);
            font-family: 'Century Gothic', CenturyGothic, AppleGothic, sans-serif;
            text-align: center;
            color: black;
            height: 100%;
            width: 100%;
            background-image: url(../../../Content/Images/background.png);
            background-size: cover;
            overflow: hidden;
        }

        .full {
            no-repeat: center center fixed;
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        .page-container {
            position: relative;
            margin: 3% auto 0 auto;
            z-index: 2;
        }

        h1 {
            font-size: 80px;
            color: #274683;
            font-family: 'Century Gothic', CenturyGothic, AppleGothic, sans-serif;
        }

        .form-login {
            max-width: 100%;
            padding: 19px 29px 29px;
            margin: 0 auto 20px;
        }
        #headerFull{
            margin-top: 15%;
        }
    </style>
    <script type="text/javascript">
        function nobackbutton() {
            window.location.hash = "no-back-button";
            window.location.hash = "Again-No-back-button" //chrome        
            window.onhashchange = function () { window.location.hash = "no-back-button"; }
        }
    </script>
</head>
<body onload="nobackbutton();">
    <div id="headerFull">
        <a href="<% = ResolveClientUrl("~/Aplication/Pages/Public/Index.aspx") %>">
            <img src="<% = ResolveClientUrl("~/Content/images/logoetb.png") %>" style="max-width: 400px;" title="ETB" />
        </a>
        <h1>BIENVENIDO</h1>
    </div>
    <script src="<% = ResolveClientUrl("~/Content/js/jquery.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/jquery/jquery-ui.js") %>"></script>
    <script src="<% = ResolveClientUrl("~/Content/js/bootstrap.min.js") %>"></script>
    <script type="text/javascript">
        function Goto() {
            console.log("entro");
            let url = window.location.origin.toString() + "/Aplication/Pages/Public/Index.aspx";
            window.location = url;
        }
    </script>
</body>
</html>