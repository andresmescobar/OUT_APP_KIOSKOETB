using Data.Model;
using OUT_APP_KIOSKOETB.Util;
using System;
using System.Web.UI;

namespace OUT_APP_KIOSKOETB.Aplication.Pages.Private
{
    public partial class UltimaFactura : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            UltimaFac();
        }

        public void UltimaFac()
        {
            try
            {
                var telefono = (string)Session["telefono"];
                var idTransaccion = (int)Session["idTransaccion"];

                ConsumoWS ultima =  new ConsumoWS();
                var ultFactura = ultima.UltimaFactura(telefono);

                if (ultFactura != "")
                {
                    string factura = ultFactura;
                    string[] subs = factura.Split(':', '\r', '\n', '{', '}', '"');
                    
                    txb_PeriodoFacturado.Text = subs[19];
                    txb_CuentaDeFacturacion.Text = subs[26];
                    txb_DireccionDeFacturacion.Text = subs[33];
                    txb_FechaLimiteDeFacturacion.Text = subs[40];
                    txb_NumeroDeFacturacion.Text = subs[52];
                    txb_TipoDeEntrega.Text = subs[66];
                    txb_CorreoElectronico.Text = subs[73];
                    txb_FechaLimiteDePago.Text = subs[92].Substring(0,10);

                    txb_Banco.Text = subs[107];
                    txb_FechaDePago.Text = subs[114].Substring(0,10);
                    txb_TipoDePago.Text = subs[123];
                    txb_Valor.Text = subs[135];
                }
                else
                {
                    string mensaje = "swal.fire('Alerta','No se encuentra una factura asociada al cliente.','warning');";
                    ClientScript.RegisterStartupScript(GetType(), "Message", mensaje, true);
                }
                                
                //using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                //{

                //    LogFactura factura = new LogFactura();
                //    factura.UserTel = telefono;
                //    factura.Accion = "Ultima factura";
                //    factura.FechaCreacion = DateTime.Now;
                //    factura.IdTransaccion = idTransaccion;
                //    db.LogFactura.Add(factura);
                //    db.SaveChanges();
                //}
            }
            catch (Exception ex)
            {
                string mensaje = "swal.fire('Alerta','" + ex.Message + "','warning');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Message", mensaje, true);
            }
        }

        protected void LogoutUsuario(object sender, EventArgs e)
        {
            try
            {
                var telefono = (string)Session["telefono"];
                var idTransaccion = (int)Session["idTransaccion"];

                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {

                    LogFactura factura = new LogFactura();
                    factura.UserTel = telefono;
                    factura.Accion = "Logout factura";
                    factura.FechaCreacion = DateTime.Now;
                    factura.IdTransaccion = idTransaccion;
                    db.LogFactura.Add(factura);
                    db.SaveChanges();
                }

                Session.Abandon();
                Session.Contents.RemoveAll();
                Response.Redirect("~/Aplication/Pages/Public/Index.aspx");
            }
            catch (Exception ex)
            {
                string mensaje = "swal.fire('Alerta','" + ex.Message + "','warning');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Message", mensaje, true);
            }
        }

        protected void Atras(object sender, EventArgs e)
        {
            try
            {
                var telefono = (string)Session["telefono"];
                var idTransaccion = (int)Session["idTransaccion"];

                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {

                    LogFactura factura = new LogFactura();
                    factura.UserTel = telefono;
                    factura.Accion = "Atras ultima factura";
                    factura.FechaCreacion = DateTime.Now;
                    factura.IdTransaccion = idTransaccion;
                    db.LogFactura.Add(factura);
                    db.SaveChanges();
                }

                Response.Redirect("~/Aplication/Pages/Private/Home.aspx");
            }
            catch (Exception ex)
            {
                string mensaje = "swal.fire('Alerta','" + ex.Message + "','warning');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Message", mensaje, true);
            }
        }
    }
}