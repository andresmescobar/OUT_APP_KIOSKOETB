var Timer;
var Sesion;
const hostURL = window.location.origin.toString();
var Document = "";
$(document).ready(function () {
    $("#Carga").css("width", "100%");
    $("#Carga").css("height", "100%");

    // Verificamos si el navegador soporta el locaStorage
    //if (typeof (Storage) !== "undefined") {
    //    let idTran = localStorage.getItem("IdTransaccion");
    //    if (idTran == null) {
    //        let url = window.location.origin.toString() + "/Aplication/Pages/Public/Index/Inicio.aspx?Status=Not_Registered";
    //        window.location = url;
    //    } else {
    //        Document = document;
    //    }
    //} else {
    //    var url = hostURL + "/Aplication/Pages/Public/Error/Error500/Error501.aspx?Error=Lo sentimos, el navegador utilizado no soporta todas las funcionalidades necesarias para el correcto funcionamiento del aplicativo, por favor intente con un navegador diferente o usar la última versión del que esté utilizando actualmente.";
    //    window.location = url;
    //}
    /***************************************************************************************************************************************************
    FUNCIONES ESPECIALES Y EVENTOS
    ***************************************************************************************************************************************************/
    // Función para el botón ir arriba
    $('.ir-arriba').click(function () {
        $('body, html').animate({
            scrollTop: '0px'
        }, 350);
    });

    $(window).scroll(function () {
        if ($(this).scrollTop() > 0) {
            $('.ir-arriba').slideDown(300);
        } else {
            $('.ir-arriba').slideUp(300);
        }
    });
    setTimeout("$('.ir-arriba').click();", 500);
    $('.ir-arriba').slideUp(300);
    //
    //Función para detectar el cierre de la pestaña
    
    // Función para crear el class que solo permite escribir números en el campo
    $('.onlyNumber').keyup(function () {
        this.value = (this.value + '').replace(/[^0-9]/g, '');
    });

    $(".onlyNumber").keydown(function (e) {
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 110, 190]) !== -1 ||
            (e.keyCode == 65 && e.ctrlKey === true) ||
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            return;
        }

        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });
    //TransaccionAjax_VerifyBD();
    detectInactivity();
});

//Función encargada de detectar actividad sobre la página y el iframe
function detectInactivity() {
    $(document).keyup(function (event) {
        resetLogout();
    });
    $(document).click(function (event) {
        resetLogout();
    });
    $("button").click(function (event) {
        resetLogout();
    });

    $(window).on('blur', function (e) {
        if ($(this).data('mouseIn') != 'yes') return;
        $('iframe').filter(function () {
            return $(this).data('mouseIn') == 'yes';
        }).trigger('iframeclick');
    });

    $(window).mouseenter(function () {
        $(this).data('mouseIn', 'yes');
    }).mouseleave(function () {
        $(this).data('mouseIn', 'no');
    });

    $('iframe').mouseenter(function () {
        $(this).data('mouseIn', 'yes');
        $(window).data('mouseIn', 'yes');
    }).mouseleave(function () {
        $(this).data('mouseIn', null);
    });

    $('iframe').on('iframeclick', function () {
        resetLogoutIframe();
    });
    $(window).on('click', function () {
        resetLogout();
    }).blur(function () {
        resetLogoutIframe();
    });

    $('<button id="ddsa" type="button" style="position:absolute;opacity:0;height:0px;width:0px;"></button>').appendTo(document.body).blur(function () {
        resetLogoutIframe();
    }).focus();
}

/***************************************************************************************************************************************************
TRANSACCIONES DE SESSION
***************************************************************************************************************************************************/

//Función encargada enviar una solicitud de consulta a la BD para validar conección
//function TransaccionAjax_VerifyBD() {
//    StartTransaccion();
//    $.ajax({
//        type: "POST",
//        url: hostURL + "/Aplication/Pages/Masterpages/MasterController.aspx",
//        data: {
//            "action": "BD_ON"
//        },
//        success: function (result) {
//            if (result != "Kiosco OK") {
//                var url = hostURL + "/Aplication/Pages/Public/Error/Error500/Error501.aspx?Error=" + result;
//                window.location = url;
//            }
//        }
//    })
//  .done(function (data, textStatus, jqXHR) {
//      resetLogout();
//      EndTransaccion();
//  })
//  .fail(function (jqXHR, textStatus, errorThrown) {
//      if (console && console.log) {
//          setTimeout(console.error.bind(console, 'El ingreso ha fallado ' + errorThrown));
//          MensajeGeneral("¡Error en Transacción!", "Lo sentimos, ocurrió un error y no se logró hacer la validación de los datos, por favor intente más tarde.", "E");
//          setTimeout("GoToInicio();", 2001);
//      }
//  });
//}

//Función encargada de enviar la solicitud de cierre de una transaccion
function Transaccion_CerrarTransaccion(action, idtran) {
    $.ajax({
        type: "POST",
        url: hostURL + "/Aplication/Pages/Masterpages/MasterController.aspx",
        data: {
            "action": action,
            "idTransaccion": idtran
        },
        success: function (result) {
        }
    });
}

//Función encargada de enviar la solicitud nuevo log de página visitada
function Transaccion_InsertLogTransaccion(idtran, idpag) {
   
    $.ajax({
        type: "POST",
        url: hostURL + "/Aplication/Pages/Masterpages/MasterController.aspx",
        data: {
            "action": "LogVentanas",
            "idTransaccion": idtran,
            "idVentana": idpag
        },
        success: function (result) {
        }
    });
}

/***************************************************************************************************************************************************
DIV CONTROL DE CARGA
***************************************************************************************************************************************************/
//Mostramos el Div de Carga y eliminamos los scroll
function StartTransaccion() {
    var html = jQuery('html');
    html.css('overflow', 'hidden');
    $("#Carga").show();
}

//Ocultamos el Div de carga y volvemos a activar el scroll
function EndTransaccion() {
    var html = jQuery('html');
    html.css('overflow', 'auto');
    $("#Carga").fadeOut();
}

function resetLogout() {
    //clearTimeout(Sesion);
    //Sesion = setTimeout('GoToLogin();', 30000); //Medio min
}

function resetLogoutIframe() {
    //clearTimeout(Sesion);
    //Sesion = setTimeout('GoToLogin();', 600000); //Diez min
}

/***************************************************************************************************************************************************
MENSAJES Y ALERTAS
***************************************************************************************************************************************************/
//Función encargada de generar los mensajes de alerta
function MensajeGeneral(Title, Mensaje, Tipo) {
    $(".alertMessage").slideUp();
    clearTimeout(Timer);
    var htmlText = "<strong>" + Title + "</strong><br />" + Mensaje;
    switch (Tipo) {
        case "W":
            $("#Mensaje_Warnig").html(htmlText);
            $("#WarnigAlert").slideDown();
            break;
        case "E":
            $("#Mensaje_Error").html(htmlText);
            $("#ErrorAlert").slideDown();
            break;
        case "S":
            $("#Mensaje_Success").html(htmlText);
            $("#SuccessAlert").slideDown();
            break;
        case "I":
            $("#Mensaje_Info").html(htmlText);
            $("#InfoAlert").slideDown();
            break;
        default:
            $("#Mensaje_Info").html(htmlText);
            $("#InfoAlert").slideDown();
            break;
    }
    Timer = setTimeout('$(".alertMessage").slideUp()', 7000);
}

//Función que cierra el mensaje de alerta generado
function CloseAlert(Mensaje) {
    clearTimeout(Timer);
    switch (Mensaje) {
        case "W":
            $("#WarnigAlert").slideUp();
            break;
        case "E":
            $("#ErrorAlert").slideUp();
            break;
        case "S":
            $("#SuccessAlert").slideUp();
            break;
        case "I":
            $("#InfoAlert").slideUp();
            break;
    }
}

//Función encargada de redirigir al usuario a la pagina de inicio
function GoToInicio() {
    StartTransaccion();
    let idTran = localStorage.getItem("IdTransaccion");
    if (idTran != null) {
        Transaccion_CerrarTransaccion("SalidaPersona", idTran);
        localStorage.removeItem("IdTransaccion");
    }
    let url = hostURL + "/Aplication/Pages/Public/Default.aspx";
    window.location = url;
}

//Función encargada de redirigir al usuario a la pagina de inicio
function GoToLogin() {
    StartTransaccion();
    let idTran = localStorage.getItem("IdTransaccion");
    if (idTran != null) {
        Transaccion_CerrarTransaccion("SalidaPersona", idTran);
        localStorage.removeItem("IdTransaccion");
    }
    let url = hostURL + "/Aplication/Pages/Public/Default.aspx";
    window.location = url;
}

/***************************************************************************************************************************************************
FUNCIONES ESPECIALES
***************************************************************************************************************************************************/

//Función que toma el valor que se pasa como parámetro mediante la URL
function getParameterByName(name) {
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
    var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
    results = regex.exec(location.search);
    return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
}

//Función que transforma todo el texto que se escribe en el imput de nombre de usuario en minúsculas
function textToLower(e, IDControl) {
    if (e.value.toString().length > 0) {
        $("#" + IDControl).css("text-transform", "lowercase");
        e.value = e.value.toLowerCase();
    } else {
        $("#" + IDControl).css("text-transform", "capitalize");
    }
}

//Función que transforma todo el texto que se escribe en el imput de nombre de usuario en minúsculas
function textToUpper(e, IDControl) {
    if (e.value.toString().length > 0) {
        $(".login input[type=text]").css("text-transform", "uppercase");
        e.value = e.value.toLowerCase();
    } else {
        $(".login input[type=text]").css("text-transform", "capitalize");
    }
}

//Función que devuelve capitalizada una palabra, se llama text.capitalize();
String.prototype.capitalize = function () {
    let text = this.toLowerCase();
    return text.replace(/(^|\s)([a-z])/g, function (m, p1, p2) { return p1 + p2.toUpperCase(); });
};

//Función que capitaliza parrafos, colocando las iniciales despues de un punto en Mayúscula
String.prototype.capitalizeParagraph = function () {
    var res = "";
    var paragraphs = this.split(".");
    for (var i = 0; i < paragraphs.length ; i++) {
        var temp = paragraphs[i].trim();
        res += "." + temp.charAt(0).toUpperCase() + temp.slice(1).toLowerCase();
    }
    return res.slice(1);
};