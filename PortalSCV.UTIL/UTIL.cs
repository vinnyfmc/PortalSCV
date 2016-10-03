using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using System.Web.UI.WebControls;

namespace PortalSCV.UTIL
{
    public static class UTIL
    {
        public static DropDownList PreencheSelect(object objData, DropDownList objSelect, string DataTextField, string DataValueField, string ValorDefault = "", string ValorSelecionado = "")
        {

            objSelect.DataSource = objData;
            objSelect.DataTextField = DataTextField;
            objSelect.DataValueField = DataValueField;
            objSelect.DataBind();

            //INSERE VALORE DEFAULT EM PRIMEIRO LUGAR
            if (ValorDefault.Trim().Length > 0)
            {
                ListItem item = new ListItem();
                item.Text = ValorDefault;
                item.Value = "";
                objSelect.Items.Insert(0, item);
            }

            //PREENCHE UM VALOR JÁ SELECIONADO
            if (ValorSelecionado.Trim().Length > 0)
                objSelect.SelectedValue = ValorSelecionado;

            return objSelect;
        }

        public static ListBox PreencheList(object objData, ListBox objSelect, string DataTextField, string DataValueField)
        {

            objSelect.DataSource = objData;
            objSelect.DataTextField = DataTextField;
            objSelect.DataValueField = DataValueField;
            objSelect.DataBind();

            return objSelect;
        }

        public static string GerarHashMd5(string input)
        {
            MD5 md5Hash = MD5.Create();
            // Converter a String para array de bytes, que é como a biblioteca trabalha.
            byte[] data = md5Hash.ComputeHash(Encoding.UTF8.GetBytes(input));

            // Cria-se um StringBuilder para recompôr a string.
            StringBuilder sBuilder = new StringBuilder();

            // Loop para formatar cada byte como uma String em hexadecimal
            for (int i = 0; i < data.Length; i++)
            {
                sBuilder.Append(data[i].ToString("x2"));
            }

            return sBuilder.ToString();
        }
        
        public static void EnviarEmail(string emailPara, string assunto, string mensagem)
        {
            try
            {
                var fromAddress = new MailAddress("portalscv@gmail.com", "PORTAL SCV");
                var toAddress = new MailAddress(emailPara);


                var smtp = new SmtpClient
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    DeliveryMethod = SmtpDeliveryMethod.Network,
                    UseDefaultCredentials = false,
                    Credentials = new NetworkCredential("portalscv@gmail.com", "admin12345@")
                };
                using (var message = new MailMessage(fromAddress, toAddress)
                {
                    IsBodyHtml = true,
                    Subject = assunto,
                    Body = mensagem
                })
                {
                    smtp.Send(message);
                }

            }
            catch (Exception ex)
            {
                throw new Exception("Erro ao enviar e-mail.", ex);
            }
        }
        
        public static DataTable ListToDataTable<T>(this IList<T> data)
        {
            PropertyDescriptorCollection props = TypeDescriptor.GetProperties(typeof(T));
            DataTable table = new DataTable();
            for (int i = 0; i < props.Count; i++)
            {
                PropertyDescriptor prop = props[i];
                table.Columns.Add(prop.Name);
            }
            object[] values = new object[props.Count];
            foreach (T item in data)
            {
                for (int i = 0; i < values.Length; i++)
                {
                    values[i] = props[i].GetValue(item);
                }
                table.Rows.Add(values);
            }
            return table;
        }
        
        public static string GenericListToXML(object obj)
        {
            string XML = "";
            string XML_CHILD = "";
            Type type = obj.GetType();
            PropertyInfo[] properties = type.GetProperties();

            if (type.FullName.ToString().Contains("Estoque.DAL"))
            {
                foreach (PropertyInfo property in properties)
                {

                    if (property.GetValue(obj, null) != null)
                    {
                        XML_CHILD = GenericListToXML(property.GetValue(obj, null));
                        if (XML_CHILD.Length > 0)
                        {
                            XML += "<" + property.Name.ToUpper() + ">";
                            XML += XML_CHILD;
                            XML += "</" + property.Name.ToUpper() + ">";
                        }
                        else
                            XML += "<" + property.Name.ToUpper() + ">" + property.GetValue(obj, null).ToString() + "</" + property.Name.ToUpper() + ">";

                    }
                }
            }

            return XML;
        }

        public static string DataTableToJson(DataTable dt)
        {

            StringBuilder JsonString = new StringBuilder();

            JsonString.Append("{ ");
            JsonString.Append("\"ROW\":[ ");

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                JsonString.Append("{ ");

                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    if (j < dt.Columns.Count - 1)
                    {
                        JsonString.Append("\"" + dt.Columns[j].ColumnName + "\":\"" +
                                          dt.Rows[i][j].ToString() + "\",");
                    }
                    else if (j == dt.Columns.Count - 1)
                    {
                        JsonString.Append("\"" + dt.Columns[j].ColumnName + "\":\"" +
                                          dt.Rows[i][j].ToString() + "\"");
                    }
                }
                /*end Of String*/
                if (i == dt.Rows.Count - 1)
                {
                    JsonString.Append("} ");
                }
                else
                {
                    JsonString.Append("}, ");
                }
            }
            JsonString.Append("]}");
            return JsonString.ToString();
        }

        public static bool ValidarEmail(string Email)
        {
            bool ValidEmail = false;
            int indexArr = Email.IndexOf("@");
            if (indexArr > 0)
            {
                if (Email.IndexOf("@", indexArr + 1) > 0)
                {
                    return ValidEmail;
                }

                int indexDot = Email.IndexOf(".", indexArr);
                if (indexDot - 1 > indexArr)
                {
                    if (indexDot + 1 < Email.Length)
                    {
                        string indexDot2 = Email.Substring(indexDot + 1, 1);
                        if (indexDot2 != ".")
                        {
                            ValidEmail = true;
                        }
                    }
                }
            }
            return ValidEmail;
        }

        public static bool IsCpf(string cpf)
        {
            int[] multiplicador1 = new int[9] { 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplicador2 = new int[10] { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };
            string tempCpf;
            string digito;
            int soma;
            int resto;
            cpf = cpf.Trim();
            cpf = cpf.Replace(".", "").Replace("-", "");
            if (cpf.Length != 11)
                return false;
            tempCpf = cpf.Substring(0, 9);
            soma = 0;

            for (int i = 0; i < 9; i++)
                soma += int.Parse(tempCpf[i].ToString()) * multiplicador1[i];
            resto = soma % 11;
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;
            digito = resto.ToString();
            tempCpf = tempCpf + digito;
            soma = 0;
            for (int i = 0; i < 10; i++)
                soma += int.Parse(tempCpf[i].ToString()) * multiplicador2[i];
            resto = soma % 11;
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;
            digito = digito + resto.ToString();
            return cpf.EndsWith(digito);
        }

        public static bool IsCnpj(string cnpj)
        {
            int[] multiplicador1 = new int[12] { 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            int[] multiplicador2 = new int[13] { 6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2 };
            int soma;
            int resto;
            string digito;
            string tempCnpj;
            cnpj = cnpj.Trim();
            cnpj = cnpj.Replace(".", "").Replace("-", "").Replace("/", "");
            if (cnpj.Length != 14)
                return false;
            tempCnpj = cnpj.Substring(0, 12);
            soma = 0;
            for (int i = 0; i < 12; i++)
                soma += int.Parse(tempCnpj[i].ToString()) * multiplicador1[i];
            resto = (soma % 11);
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;
            digito = resto.ToString();
            tempCnpj = tempCnpj + digito;
            soma = 0;
            for (int i = 0; i < 13; i++)
                soma += int.Parse(tempCnpj[i].ToString()) * multiplicador2[i];
            resto = (soma % 11);
            if (resto < 2)
                resto = 0;
            else
                resto = 11 - resto;
            digito = digito + resto.ToString();
            return cnpj.EndsWith(digito);
        }

        public static T Parse<T>(string value)
        {
            return (T)TypeDescriptor.GetConverter(typeof(T)).ConvertFromString(value);
        }

        public static string RetiraFormatacao(string text, string[] Formats)
        {
            foreach (string chr in Formats)
            {
                text = text.Replace(chr, "");
            }

            return text;
        }

    }
}
