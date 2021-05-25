using Data.Model;
using System;
using System.Web.UI;

namespace OUT_APP_KIOSKOETB.Aplication.Pages.Private
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        public void UltimaFacturas(object sender, EventArgs e)
        {
            try
            {
                var telefono = (string)Session["telefono"];
                var idTransaccion = (int)Session["idTransaccion"];

                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {

                    LogHome home = new LogHome();
                    home.UserTel = telefono;
                    home.Accion = "Ultima Factura";
                    home.FechaCreacion = DateTime.Now;
                    home.IdTransaccion = idTransaccion;
                    db.LogHome.Add(home);
                    db.SaveChanges();
                }

                Response.Redirect("~/Aplication/Pages/Private/UltimaFactura.aspx");
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

                    LogHome home = new LogHome();
                    home.UserTel = telefono;
                    home.Accion = "Logout Home";
                    home.FechaCreacion = DateTime.Now;
                    home.IdTransaccion = idTransaccion;
                    db.LogHome.Add(home);
                    db.SaveChanges();
                }

                Session.Contents.RemoveAll();
                Response.Redirect("~/Aplication/Pages/Public/Index.aspx");
            }
            catch (Exception ex)
            {
                string mensaje = "swal.fire('Alerta','" + ex.Message + "','warning');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Message", mensaje, true);
            }
        }

        protected void ConsultarFacturas(object sender, EventArgs e)
        {
            try
            {
                var telefono = (string)Session["telefono"];
                var idTransaccion = (int)Session["idTransaccion"];

                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {

                    LogHome home = new LogHome();
                    home.UserTel = telefono;
                    home.Accion = "Consultar Facturas";
                    home.FechaCreacion = DateTime.Now;
                    home.IdTransaccion = idTransaccion;
                    db.LogHome.Add(home);
                    db.SaveChanges();
                }

                Response.Redirect("~/Aplication/Pages/Private/ImprimirFactura.aspx");
            }
            catch (Exception ex)
            {
                string mensaje = "swal.fire('Alerta','" + ex.Message + "','warning');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Message", mensaje, true);
            }
        }
    }
}