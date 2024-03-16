using System.Data;
using System.Data.SqlClient;
using System.Xml.Serialization;
using System.Xml;
using Newtonsoft.Json;

namespace Practical.Helper
{
    public class DBHelper
    {

        public DataTable GetDateTableFromQuery(string Squery, string Connstr)
        {

            DataTable dataTable = new DataTable
            {
                TableName = "datatable1"
            };
            var conn = new SqlConnection(Connstr);
            using (var cmd = conn.CreateCommand())
            {
                try
                {
                    cmd.CommandText = Squery;//
                    cmd.CommandTimeout = 6000;
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    conn.Close();
                    da.Fill(dataTable);
                    da.Dispose();
                    conn.Close();
                }
                catch (Exception)
                {
                    throw;
                }


            }


            return dataTable;
        }

        public string ConvertToXML(dynamic Object)
        {
            XmlDocument xd = new XmlDocument();
            XmlSerializer xmlSerializer = new XmlSerializer(Object.GetType());

            using (MemoryStream xmlStream = new MemoryStream())
            {
                xmlSerializer.Serialize(xmlStream, Object);
                xmlStream.Position = 0;
                xd.Load(xmlStream);
            }
            return xd.InnerXml;
        }

        public string convertToJson(dynamic Object)
        {
            return JsonConvert.SerializeObject(Object);
        }
    }
}
