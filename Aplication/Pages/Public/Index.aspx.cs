using Data.Model;
using OUT_APP_KIOSKOETB.Util;
using System;

namespace OUT_APP_KIOSKOETB.Aplication.Pages.Public
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void btn_Consult_Click(object sender, EventArgs e)
        {

            Session["telefono"] = document.Text;

            string telefono = document.Text;

            ConsumoWS usuario = new ConsumoWS();
            var usu = usuario.ConsultarUsuario(telefono);


            
            if (usu == true)
            {
                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {
                    LogInicio inicio = new LogInicio();

                    inicio.UserTel = document.Text;
                    inicio.Accion = "Iniciar Sesión";
                    inicio.FechaCreacion = DateTime.Now;

                    db.LogInicio.Add(inicio);
                    db.SaveChanges();

                    Session["idTransaccion"] = inicio.Id;
                }

                Response.Redirect("~/Aplication/Pages/Private/Home.aspx");
            }
            else
            {
                string mensaje = "swal.fire('Alerta','El número ingresado no se encuentra asociado a ningun cliente.','warning');";
                ClientScript.RegisterStartupScript(GetType(), "Message", mensaje, true);
            }
        }
    }
}