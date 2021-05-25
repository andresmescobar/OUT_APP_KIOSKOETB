using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OUT_APP_KIOSKOETB.Util
{
    public class WSResponseFactura
    {
        public string Adjust { get; set; }
        public string Barcode { get; set; }
        public string Billing_Account { get; set; }
        public string Billing_Address { get; set; }
        public string Billing_Cutoff_Date { get; set; }
        public string Billing_Phone { get; set; }
        public string Billing_Number_PSE { get; set; }
        public string Delivery_Type { get; set; }
        public string Email { get; set; }
        public string Extemporaneous { get; set; }
        public string Invoice_Origin { get; set; }
        public string Payday_Limit { get; set; }
        public string Payment_Date { get; set; }
        public string Phone { get; set; }
        public string State { get; set; }
        public string Value_Original { get; set; }
        public string Value_Final { get; set; }
        public string Value_Final_Str { get; set; }
        public Payment payment { get; set; }
    }

    public class Payment
    {
        public string Payment_Date { get; set; }
        public string Type { get; set; }
        public string Value { get; set; }
        public string Value_Str { get; set; }
    }

    public class ImprimirFactura
    {
        public string File_URL { get; set; }
    }
}