using Data.Model;
using OUT_APP_KIOSKOETB.Util;
using System;
using System.Web.UI;

namespace OUT_APP_KIOSKOETB.Aplication.Pages.Private
{
    public partial class ImprimirFactura : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btn_ConsultarFacturaImprimir.Visible = false;
            }
        }

        protected void ConsultarFacturaImprimir(object sender, EventArgs e)
        {
            try
            {
                var telefono = (string)Session["telefono"];
                var idTransaccion = (int)Session["idTransaccion"];

                string fech = fecha.Text;
                string[] subs = fech.Split('-');
                string fec = subs[0] + subs[1];

                ConsumoWS consumo = new ConsumoWS();
                var factura = consumo.ImprimirFactura(fec, telefono);

                if (factura != null && factura != "")
                {
                    fact.Src = factura;
                }
                else
                {
                    string mensaje = "swal.fire('Alerta','No se encuentran facturas asociadas al periodo seleccionado.','warning');";
                    ClientScript.RegisterStartupScript(GetType(), "Message", mensaje, true);
                }
                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {

                    LogImprimirFactura imprimnirFac = new LogImprimirFactura();
                    imprimnirFac.UserTel = telefono;
                    imprimnirFac.Accion = "Consultar Factura por periodo";
                    imprimnirFac.FechaCreacion = DateTime.Now;
                    imprimnirFac.IdTransaccion = idTransaccion;
                    db.LogImprimirFactura.Add(imprimnirFac);
                    db.SaveChanges();
                }
            }
            catch (Exception ex)
            {
                string mensaje = "swal.fire('Alerta','" + ex.Message + "','warning');";
                ScriptManager.RegisterStartupScript(Page, GetType(), "Message", mensaje, true);
            }
        }

        protected void Imprimir(object sender, EventArgs e)
        {
            //fecha.Text;

            //string[] subs = fech.Split('-');
            //string fec = subs[0] + subs[1];



            //PdfDocument document = new PdfDocument();
            //PdfPage page = document.AddPage();
            //XGraphics gfx = XGraphics.FromPdfPage(page);
            //XFont font = new XFont("Verdana", 20, XFontStyle.BoldItalic);
            //// Draw the text 
            //gfx.DrawString("Hello, World!", font, XBrushes.Black,
            //    new XRect(0, 0, page.Width, page.Height),
            //    XStringFormats.Center);

            //PdfDictionary dict = new PdfDictionary(document);
            //dict.Elements["/S"] = new PdfName("/JavaScript"); 
            //dict.Elements["/JS"] = new PdfString("this.print(true);\r");
            //document.Internals.AddObject(dict);
            //document.Internals.Catalog.Elements["/OpenAction"] =
            //    PdfInternals.GetReference(dict);
            //document.Save(Server.MapPath("~https://strprtlprofija.blob.core.windows.net/1022386704/FACTURAS/12053574142-291741426-202104.pdf"));
            //fact.Attributes["src"] = "~https://strprtlprofija.blob.core.windows.net/1022386704/FACTURAS/12053574142-291741426-202104.pdf";

            //PrintDocument printDocument1 = new PrintDocument();
            //PrinterSettings ps = new PrinterSettings();
            //printDocument1.PrinterSettings = ps;
            //printDocument1.PrintPage += Imprimir2;
            //printDocument1.Print();


            //PrintDocument pd = new PrintDocument();
            //pd.PrintPage += new PrintPageEventHandler(Imprimir2);
            //pd.Print();
        }



        protected void LogoutUsuario(object sender, EventArgs e)
        {
            try
            {
                var telefono = (string)Session["telefono"];
                var idTransaccion = (int)Session["idTransaccion"];

                using (dboKioscoETBEntities db = new dboKioscoETBEntities())
                {

                    LogImprimirFactura imprimnirFac = new LogImprimirFactura();
                    imprimnirFac.UserTel = telefono;
                    imprimnirFac.Accion = "Logout Imprimir";
                    imprimnirFac.FechaCreacion = DateTime.Now;
                    imprimnirFac.IdTransaccion = idTransaccion;
                    db.LogImprimirFactura.Add(imprimnirFac);
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

                    LogImprimirFactura imprimnirFac = new LogImprimirFactura();
                    imprimnirFac.UserTel = telefono;
                    imprimnirFac.Accion = "Atras Imprimir";
                    imprimnirFac.FechaCreacion = DateTime.Now;
                    imprimnirFac.IdTransaccion = idTransaccion;
                    db.LogImprimirFactura.Add(imprimnirFac);
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

        protected void fecha_TextChanged(object sender, EventArgs e)
        {
            string fech = fecha.Text;

            if (fech != "")
            {
                btn_ConsultarFacturaImprimir.Visible = true;
            }
            else
            {
                btn_ConsultarFacturaImprimir.Visible = false;
            }
        }
    }
}