using Data.Model;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using RestSharp;
using System;
using System.Linq;

namespace OUT_APP_KIOSKOETB.Util
{
    public class ConsumoWS
    {
        public string GenerarToken()
        {
            try
            {
                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {
                    var UrlWS = db.Dato.Where(x => x.Id == 6 && x.Activo == true).FirstOrDefault();
                    var UrlAutenticateWS = db.Dato.Where(x => x.Id == 3 && x.Activo == true).FirstOrDefault();
                    var UsuarioWS = db.Dato.Where(x => x.Codigo == "Usuario" && x.Activo == true && x.Herancia == "CredencialesWS").FirstOrDefault();
                    var PasswordWS = db.Dato.Where(x => x.Codigo == "Password" && x.Activo == true && x.Herancia == "CredencialesWS").FirstOrDefault();

                    string tokens = "";

                    string parametro = "{\r\n    \"WSRequestHeader\": {\r\n        \"System\": {\r\n            \"name\": \"KIOSKO\",\r\n            \"correlationID\": \"Identificador_Unico_Peticion\",\r\n            \"processingServer\": \"\"\r\n        },\r\n        \"Property\": []\r\n    },\r\n    \"WSRequestBody\": {\r\n        \"Audit\": {\r\n            \"Canal\": \"KIOSKO\",\r\n            \"Id_Device\": \"\",\r\n            \"SO\": \"\",\r\n            \"IP_Address\": \"\",\r\n            \"IP_Latitude\": \"\",\r\n            \"IP_Longitude\": \"\",\r\n            \"WhatsApp_Phone_Number\": \"\",\r\n            \"Facebook_User\": \"\",\r\n            \"Twitter_User\": \"\"\r\n        },\r\n        \"Password\": \""+PasswordWS.Nombre+"\",\r\n    \"Username\": \""+UsuarioWS.Nombre+"\" \r\n    }\r\n}";

                    var client = new RestClient(UrlAutenticateWS.Nombre);
                    var request = new RestRequest(Method.POST);
                    request.AddHeader("content-type", "application/json");
                    request.AddParameter("application/json", parametro, ParameterType.RequestBody);
                    IRestResponse response = client.Execute(request);
                                        
                    if (response.IsSuccessful)
                    {
                        dynamic js = JsonConvert.DeserializeObject(response.Content);
                        tokens = js.WSResponseBody.SecurityToken;
                    }
                    return tokens;
                }
            }
            catch (Exception)
            {
                throw;
            }            
        }


        public bool ConsultarUsuario(string telefono)
        {
            try
            {
                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {                    
                    var UrlClienteWS = db.Dato.Where(x => x.Id == 5 && x.Activo == true).FirstOrDefault();                    

                    var token = GenerarToken();
                    bool cliente = false;

                    if (token != "")
                    {
                        string parametro = "{\r\n    \"WSRequestHeader\": {\r\n        \"System\": {\r\n            \"name\": \"KIOSKO\",\r\n            \"correlationID\": \"Identificador_Unico_Peticion\",\r\n            \"processingServer\": \"\"\r\n        },\r\n        \"Property\": []\r\n    },\r\n    \"WSRequestBody\": {\r\n        \"Audit\": {\r\n            \"Canal\": \"KIOSKO\",\r\n            \"Id_Device\": \"\",\r\n            \"SO\": \"\",\r\n            \"IP_Address\": \"\",\r\n            \"IP_Latitude\": \"\",\r\n            \"IP_Longitude\": \"\",\r\n            \"WhatsApp_Phone_Number\": \"\",\r\n            \"Facebook_User\": \"\",\r\n            \"Twitter_User\": \"\"\r\n        },\r\n        \"Billing_Account\": \"\",\r\n        \"Phone\": \""+ telefono +"\"\r\n    }\r\n}";

                        var client = new RestClient(UrlClienteWS.Nombre);
                        client.Timeout = -1;
                        var request = new RestRequest(Method.POST);
                        request.AddHeader("Content-Type", "application/json");
                        request.AddHeader("Authorization", "Bearer " + token);
                        request.AddParameter("application/json", parametro, ParameterType.RequestBody);                        
                        IRestResponse response = client.Execute(request);
                        var jsons = JObject.Parse(response.Content);
                        var stats = (string)jsons["WSResponseHeader"]["Service"]["status"];

                        if (stats == "OK")
                        {
                            cliente = true;
                        }

                        return cliente;
                    }

                    else
                    {
                        GenerarToken();
                    }

                    return cliente;
                }
            }
            catch (Exception)
            {

                throw;
            }                     
        }

        public string UltimaFactura(string telefono)
        {
            try
            {
                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {
                    var UrlUltimaFacturaWS = db.Dato.Where(x => x.Id == 5 && x.Activo == true).FirstOrDefault();

                    var token = GenerarToken();
                    string ultimaFactura = "";

                    if (token != "")
                    {
                        string parametro = "{\r\n    \"WSRequestHeader\": {\r\n        \"System\": {\r\n            \"name\": \"KIOSKO\",\r\n            \"correlationID\": \"Identificador_Unico_Peticion\",\r\n            \"processingServer\": \"\"\r\n        },\r\n        \"Property\": []\r\n    },\r\n    \"WSRequestBody\": {\r\n        \"Audit\": {\r\n            \"Canal\": \"KIOSKO\",\r\n            \"Id_Device\": \"\",\r\n            \"SO\": \"\",\r\n            \"IP_Address\": \"\",\r\n            \"IP_Latitude\": \"\",\r\n            \"IP_Longitude\": \"\",\r\n            \"WhatsApp_Phone_Number\": \"\",\r\n            \"Facebook_User\": \"\",\r\n            \"Twitter_User\": \"\"\r\n        },\r\n        \"Billing_Account\": \"\",\r\n        \"Phone\": \""+telefono+"\"\r\n    }\r\n}";

                        var client = new RestClient(UrlUltimaFacturaWS.Nombre);
                        client.Timeout = -1;
                        var request = new RestRequest(Method.POST);
                        request.AddHeader("Content-Type", "application/json");
                        request.AddHeader("Authorization", "Bearer " + token);
                        request.AddParameter("application/json", parametro, ParameterType.RequestBody);
                        IRestResponse response = client.Execute(request);
                        var jsons = JObject.Parse(response.Content);

                        var valor = jsons["WSResponseBody"];
                        var valor2 = valor["Invoices"][0];

                        var valorFinal = valor2.ToString();


                        if (valor2 != null)
                        {
                            ultimaFactura = valorFinal;
                        }

                        return ultimaFactura;
                    }

                    else
                    {
                        GenerarToken();
                    }

                    return ultimaFactura;
                }
            }
            catch (Exception)
            {
                throw;
            }
        }

        public string ImprimirFactura(string fecha, string telefono)
        {
            try
            {
                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {
                    var UrlImprimirFacturaWS = db.Dato.Where(x => x.Id == 4 && x.Activo == true).FirstOrDefault();

                    var token = GenerarToken();
                    string imprimirFactura = "";
                    

                    if (token != "")
                    {
                        string parametro = "{\r\n    \"WSRequestHeader\": {\r\n        \"System\": {\r\n            \"name\": \"KIOSKO\",\r\n            \"correlationID\": \"Identificador_Unico_Peticion\",\r\n            \"processingServer\": \"\"\r\n        },\r\n        \"Property\": []\r\n    },\r\n    \"WSRequestBody\": {\r\n        \"Audit\": {\r\n            \"Canal\": \"KIOSKO\",\r\n            \"Id_Device\": \"\",\r\n            \"SO\": \"\",\r\n            \"IP_Address\": \"\",\r\n            \"IP_Latitude\": \"\",\r\n            \"IP_Longitude\": \"\",\r\n            \"WhatsApp_Phone_Number\": \"\",\r\n            \"Facebook_User\": \"\",\r\n            \"Twitter_User\": \"\"\r\n        },\r\n        \"Document_Number\": \"\",\r\n        \"Document_Type\":  \"\",\r\n        \"Period\": \"" + fecha + "\",\r\n        \"Phone\": \""+telefono+"\"\r\n    }\r\n}";

                        var client = new RestClient(UrlImprimirFacturaWS.Nombre);
                        client.Timeout = -1;
                        var request = new RestRequest(Method.POST);
                        request.AddHeader("Content-Type", "application/json");
                        request.AddHeader("Authorization", "Bearer " + token);
                        request.AddParameter("application/json", parametro, ParameterType.RequestBody);
                        IRestResponse response = client.Execute(request);

                        var jsons = JObject.Parse(response.Content);
                        var imprimirFactura2 = jsons["File"];

                        if (imprimirFactura2 == null || imprimirFactura2.Type == JTokenType.Null)
                        {
                            return imprimirFactura;
                        }

                        imprimirFactura = (string)jsons["File"]["File_URL"];

                        return imprimirFactura;
                    }

                    else
                    {
                        GenerarToken();
                    }

                    return imprimirFactura;
                }
            }
            catch (Exception ex)
            {

                throw;
            }
        }
    }
}