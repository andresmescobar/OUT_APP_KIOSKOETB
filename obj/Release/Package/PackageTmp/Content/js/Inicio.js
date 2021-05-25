var Timer;
var Sesion;
const hostURL = window.location.origin.toString();
$(document).ready(function () {
    $("input:submit").click(function () { return false; });
    $("button").click(function () { return false; });
    $("#Carga").css("width", "100%");
    $("#Carga").css("height", "100%");

    // Verificamos si el navegador soporta el locaStorage
    if (typeof (Storage) !== "undefined") {
        console.log("prueba");
    }
    else {
        var url = hostURL + "/Aplication/Pages/Public/Error/Error500/Error501.aspx?Error=Lo sentimos, el navegador utilizado no soporta todas las funcionalidades necesarias para el correcto funcionamiento del aplicativo, por favor intente con un navegador diferente o usar la ultima versión del que actualmente esté utilizando.";
        window.location = url;
    }

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
    $('#generalForm').validate({ // initialize the plugin
        rules: {
            document: {
                required: true
            }
        },
        messages: {
            document: {
                required: 'Por favor digite un número de telefono',
                number: 'Ingrese un número de telefono valido',
                minlength: 'El número de telefono debe de tener 7 caracteres'
            }
        },
        submitHandler: function () {
            $successMsg.show();
        }
    });
    // Función para crear el class que solo permite escribir números en el campo
    $('.onlyNumber').keyup(function () {
        this.value = (this.value + '').replace(/[^0-9]/g, '');
    });

    $(".onlyNumber").keydown(function (e) { 
        val = $("#document").val();
        if (val.length >= 7) {
            $("#btn_Consult").show();
            //$("#btn_Consult").removeAttr("disabled");
            if (e.keyCode == 13) {
                consultDocument();//si da enter y la cadena cumple con la lungitud requerida se ejecuta la accion de consultar documento
            }
        } else {
            $("#btn_Consult").hide();
            //$("#btn_Consult").attr("disabled", "disabled");
            if (e.keyCode == 13) {
                return false;//Si da enter y no la cadena no cumple con la longitud requerida no hacer nada
            }
        }
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

//Función encargada de detectar actividad sobre la página
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
}

//Función que recibe el número que se ha de escribir en el control
function escribirNumero(num) {
    let val = $("#document").val();
    if (val.length >= 0 && val.length < 30) {
        $("#document").val(val + "" + num);
        if (val.length >= 6) {
            $("#btn_Consult").show();
            //$("#btn_Consult").removeAttr("disabled");
        }
    }
    $("#document").focus();
}

//Función que borra el último caracter escrito en el control
function delLastNumber() {
    let val = $("#document").val();
    if (val.length > 0) {
        let tam = val.length;
        val = val.substring(0, tam - 1);
        $("#document").val(val);
        if (val.length <= 6) {
            $("#btn_Consult").hide();
            //$("#btn_Consult").attr("disabled", "disabled");
        }
    }
    $("#document").focus();
}

//Función que limpia completamente el control del documento
function delAll() {
    $("#document").val("");
    $("#btn_Consult").hide();
    //$("#btn_Consult").attr("disabled", "disabled");
    $("#document").focus();
}

//Función que dispara el evento de consulta del documento de la persona
function consultDocument() {

    if ($("#document").val().length >= 6 && $.isNumeric($("#document").val()) && $("#document").val().length <= 30) {

        let beneficiario;
        let document = $("#document").val();


        //MensajeGeneral("No se puede validar documento", "Lo sentimos, el sistema no puede validar el documento digitado, por favor informese con el área de técnologia.", "E");
        TransaccionAjax_VerifyDocument(document);
        document = "0";


        if (document != "0") {

            if (beneficiario) {
                //InsertTransaccion(document, "1", true);
            } else {
                //InsertTransaccion(document, "2", false);
            }
        }

    } else {
        MensajeGeneral("Número Documento no valido", "Lo sentimos, el número de telefono «<b><u>" + $("#document").val() + "</u></b>» no es un número valido para el sistema.<br/>Recuerda que el número debe ser de a <b>7 caracteres</b>.", "E");
    }
}

//Función encargada de enviar los datos de la nueva transaccion para ser insertados
function InsertTransaccion(document, idpage, isBeneficiario) {

    getIP(CallTransaccion);
    function CallTransaccion(ip) {
        TransaccionAjax_InsertTransaction("IngresoPersona", document, ip, idpage, isBeneficiario);
    }
}


//Función que toma los datos de la página actualmente activa y los envia para ser insertados
function TransaccionAjax_InsertTransaction(Action, document, ip, idpage, isBeneficiario) {
    console.log(document);
    StartTransaccion();
    $.ajax({
        type: "POST",
        url: hostURL + "/Aplication/Pages/Masterpages/MasterController.aspx",
        data: {
            "action": Action,
            "Document": document,
            "IP": ip,
            "IdVentana": idpage
        },
        success: function (result) {

            let respuesta = [];
            respuesta = JSON.parse(result);


            if (respuesta[0] != "Exito") {
                MensajeGeneral(respuesta[0], "Lo sentimos, ocurrió un error al intentar insertar la transacción generada.<br/> " + respuesta[1], "E");
                setTimeout(console.error.bind(console, 'Insert Transacción ha fallado: ' + respuesta[1]));
                setTimeout("GoToInicio();", 5000);
            } else {
                let url = "";
                localStorage.setItem("IdTransaccion", respuesta[1]);
                if (isBeneficiario == true) {
                    url = hostURL + "/Aplication/Pages/Private/Main.aspx?Document=" + document;
                } else {
                    url = hostURL + "/Aplication/Pages/Private/NoBenef/NoBeneficiario.aspx?Document=" + document;
                }
                window.location = url;
            }
        }
    })
        .done(function (data, textStatus, jqXHR) {

        })
        .fail(function (jqXHR, textStatus, errorThrown) {
            if (console && console.log) {
                setTimeout(console.error.bind(console, 'El ingreso ha fallado ' + errorThrown));
                MensajeGeneral("¡Error en Transacción!", "Lo sentimos, ocurrió un error y no se logró hacer la validación de los datos, por favor intente más tarde.", "E");
                setTimeout("GoToInicio();", 5000);
            }
        });
}

//Función encargada enviar una solicitud de consulta a la BD para validar conección
//function TransaccionAjax_VerifyBD() {
//    console.log(document);
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
//            EndTransaccion();
//            //Sesion = setTimeout('window.location = hostURL', 60000);
//            //clearTimeout(Sesion);
//        }
//    })
//        .done(function (data, textStatus, jqXHR) {

//        })
//        .fail(function (jqXHR, textStatus, errorThrown) {
//            if (console && console.log) {
//                setTimeout(console.error.bind(console, 'El ingreso ha fallado ' + errorThrown));
//                MensajeGeneral("¡Error en Transacción!", "Lo sentimos, ocurrió un error y no se logró hacer la validación de los datos, por favor intente más tarde.", "E");
//                setTimeout("GoToInicio();", 2001);
//            }
//        });
//}

//Función encargada de consultar si el documento digitado es para un ciudadano beneficiario o no
//function TransaccionAjax_VerifyDocument(document) {
//    StartTransaccion();
//    //clearTimeout(Sesion);
//    //Sesion = setTimeout('window.location = hostURL', 600000);
//    $.ajax({
//        type: "POST",
//        url: hostURL + "/Aplication/Controller/Public/Index/InicioAjax.aspx",
//        data: {
//            "action": "Verify",
//            "Documento": document
//        },
//        success: function (result) {
//            if (result.length > 1) {
//                let respuesta = [];
//                respuesta = JSON.parse(result);
//                MensajeGeneral(respuesta[0], "Lo sentimos, ocurrió un error al consultar el documento del ciudadano.<br/> " + respuesta[1], "E");
//                setTimeout(console.error.bind(console, 'Verify Document ha fallado: ' + respuesta[1]));
//                setTimeout("GoToInicio();", 5000);
//            } else {
//                if (result == "1") {
//                    /*InsertTransaccion(document, "1", true);*/ //Insertar en la base de datos el ingreso de un usuario beneficiario
//                } else {
//                    /*InsertTransaccion(document, "2", false);*/  //Insertar en la base de datos el intento de ingreso de un usuario No beneficiario
//                }
//            }

//        }
//    })
//        .done(function (data, textStatus, jqXHR) {

//        })
//        .fail(function (jqXHR, textStatus, errorThrown) {
//            if (console && console.log) {
//                setTimeout(console.error.bind(console, 'El ingreso ha fallado ' + errorThrown));
//                MensajeGeneral("¡Error en Transacción!", "Lo sentimos, ocurrió un error y no se logró hacer la validación de los datos, por favor intente más tarde.", "E");
//                setTimeout("GoToInicio();", 2001);
//            }
//        });
//}


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
    // Sesion = setTimeout('window.location = hostURL', 60000);
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
    let url = hostURL + "/Aplication/Pages/Public/Index.aspx";
    window.location = url;
}

//Función encargada de redirigir al usuario a la pagina de inicio
function GoToLogin() {
    let url = hostURL + "/Aplication/Pages/Public/Index.aspx";
    window.location = hostURL;
}

/***************************************************************************************************************************************************
FUNCIONES ESPECIALES
***************************************************************************************************************************************************/

//Función encargada de consultar la IP del cliente
function getIP(callback) {
    var ip_dups = {};

    //compatibilidad exclusiva de firefox y chrome, el usuario @guzgarcia compartio este enlace muy util: http://iswebrtcreadyyet.com/
    var RTCPeerConnection = window.RTCPeerConnection
        || window.mozRTCPeerConnection
        || window.webkitRTCPeerConnection;
    var useWebKit = !!window.webkitRTCPeerConnection;

    //bypass naive webrtc blocking using an iframe
    if (!RTCPeerConnection) {
        //NOTE: necesitas tener un iframe in la pagina, exactamente arriba de la etiqueta script
        //
        //<iframe id="iframe" sandbox="allow-same-origin" style="display: none"></iframe>
        //<script>... se llama a la funcion getIPs aqui...
        //
        var win = iframe.contentWindow;
        RTCPeerConnection = win.RTCPeerConnection
            || win.mozRTCPeerConnection
            || win.webkitRTCPeerConnection;
        useWebKit = !!win.webkitRTCPeerConnection;
    }

    //requisitos minimos para conexion de datos
    var mediaConstraints = {
        optional: [{ RtpDataChannels: true }]
    };

    var servers = { iceServers: [{ urls: "stun:stun.services.mozilla.com" }] };

    //construccion de una nueva RTCPeerConnection
    var pc = new RTCPeerConnection(servers, mediaConstraints);

    function handleCandidate(candidate) {
        // coincidimos con la direccion IP
        var ip_regex = /([0-9]{1,3}(\.[0-9]{1,3}){3}|[a-f0-9]{1,4}(:[a-f0-9]{1,4}){7})/
        var ip_addr = ip_regex.exec(candidate)[1];

        //eliminamos duplicados
        if (ip_dups[ip_addr] === undefined) {
            callback(ip_addr);
        }

        ip_dups[ip_addr] = true;
    }

    //escuchamos eventos candidatos
    pc.onicecandidate = function (ice) {

        //dejamos de lado a los eventos que no son candidatos
        if (ice.candidate)
            handleCandidate(ice.candidate.candidate);
    };

    //creamos el canal de datos
    pc.createDataChannel("");

    //creamos un offer sdp
    pc.createOffer(function (result) {

        //disparamos la peticion (request) al stun server (para entender mejor debemos ver la documentacion de WebRTC.
        pc.setLocalDescription(result, function () { }, function () { });

    }, function () { });

}