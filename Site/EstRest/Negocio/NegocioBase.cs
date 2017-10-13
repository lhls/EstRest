using Conexao;
using System;
using System.Configuration;
using System.Data;
using System.IO;
using System.Text;
using System.Xml;
using System.Xml.Serialization;

namespace Negocio
{
    public class NegocioBase
    {
        public static string v_str_conexao
        {
            get
            {
#if !DEBUG
                return ConfigurationManager.AppSettings["connection_string"];
#else
                return ConfigurationManager.AppSettings["connection_string_teste"];
#endif
            }
        }

        public static object[] CarregaParametrosNulos(object[] arrParm)
        {
            for (int i = 0; i < arrParm.Length; i++)
            {
                arrParm[i] = verificaItemNulo(arrParm[i]);
            }

            return arrParm;
        }

        public virtual void inicializaVariaveis()
        {
            foreach (System.Reflection.PropertyInfo p in this.GetType().GetProperties())
            {
                switch (p.PropertyType.Name)
                {
                    case ("String"):
                        p.SetValue(this, string.Empty, null);
                        break;
                    case ("Int32"):
                        p.SetValue(this, int.MinValue, null);
                        break;
                    case ("Decimal"):
                        p.SetValue(this, decimal.MinValue, null);
                        break;
                    case ("DateTime"):
                        p.SetValue(this, DateTime.MinValue, null);
                        break;
                    default:
                        break;
                }
            }
        }

        private static object verificaItemNulo(object objParm)
        {
            if (objParm == null) return DBNull.Value; 
            else
            {
                switch (objParm.GetType().ToString())
                {
                    case ("System.String"):
                        if (string.IsNullOrEmpty(objParm.ToString())) return DBNull.Value;
                        break;
                    case ("System.Int32"):
                        if (Convert.ToInt32(objParm) == int.MinValue) return DBNull.Value;
                        break;
                    case ("System.Decimal"):
                        if (Convert.ToDecimal(objParm) == decimal.MinValue) return DBNull.Value;
                        break;
                    case ("System.DateTime"):
                        if (Convert.ToDateTime(objParm) == DateTime.MinValue) return DBNull.Value;
                        break;
                    default:
                        break;
                }
            }

            return objParm;
        }

        protected string pr_consulta = string.Empty;
        protected string pr_atualiza = string.Empty;
        protected string pr_exclui = string.Empty;

        private static void CarregaXmlNulo(XmlDocument v, object objClasse)
        {
            int i = 0;
            //Primeiro filho são os dados do xml
            //Ultimo filho são os dados da classe
            foreach (var prop in objClasse.GetType().GetProperties())
            {
                if (prop.GetValue(objClasse, null) != null)
                    if (verificaItemNulo(prop.GetValue(objClasse, null)) == DBNull.Value)
                        v.LastChild.RemoveChild(v.LastChild.SelectSingleNode("/" + objClasse.GetType().Name + "/" + prop.Name));
                i++;
            }
        }

        protected static DataSet ConsultaDataSet(string nomeProc, object[] parametros)
        {
            try
            {
                return SqlHelper.ExecuteDataset(v_str_conexao, nomeProc, CarregaParametrosNulos(parametros));
            }
            catch (Exception ex)
            {
                Console.Write(ex.StackTrace.ToString());
                return new DataSet();
            }
        }

        public virtual int EfetuarAtualizacao(int cd_usuario_logado)
        {
            return AtualizaDados(pr_atualiza, this, cd_usuario_logado);
        }

        public virtual int EfetuarAtualizacao(int cd_usuario_logado, bool retornaErro)
        {
            try
            {
                return AtualizaDados(pr_atualiza, this, cd_usuario_logado, retornaErro);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected static int AtualizaDados(string nomeProc, object objClasse, int cd_usuario_alteracao)
        {
            try
            {
                XmlDocument x = new XmlDocument();
                XmlSerializer xsSubmit = new XmlSerializer(objClasse.GetType());
                string xmlInclusao = "";

                using (StringWriter sww = new Utf8StringWriter())
                {
                    using (XmlWriter writer = XmlWriter.Create(sww))
                    {
                        xsSubmit.Serialize(writer, objClasse);
                        xmlInclusao = sww.ToString(); // Your XML
                        x.LoadXml(xmlInclusao);
                    }
                }

                CarregaXmlNulo(x, objClasse);

                return Convert.ToInt32(ConsultaDataTable(nomeProc, new object[] { x.OuterXml, cd_usuario_alteracao }).Rows[0][0]);
            }
            catch
            {
                return int.MinValue;
            }
        }

        protected static int AtualizaDados(string nomeProc, object objClasse, int cd_usuario_alteracao, bool retornaErro)
        {
            try
            {
                XmlDocument x = new XmlDocument();
                XmlSerializer xsSubmit = new XmlSerializer(objClasse.GetType());
                string xmlInclusao = "";

                using (StringWriter sww = new Utf8StringWriter())
                {
                    using (XmlWriter writer = XmlWriter.Create(sww))
                    {
                        xsSubmit.Serialize(writer, objClasse);
                        xmlInclusao = sww.ToString(); // Your XML
                        x.LoadXml(xmlInclusao);
                    }
                }

                CarregaXmlNulo(x, objClasse);

                return Convert.ToInt32(SqlHelper.ExecuteDataset(v_str_conexao, nomeProc, CarregaParametrosNulos(new object[] { x.OuterXml, cd_usuario_alteracao })).Tables[0].Rows[0][0]);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }


        protected static DataTable ConsultaDataTable(string nomeProc, object[] parametros)
        {
            try
            {
                return ConsultaDataSet(nomeProc, parametros).Tables[0];
            }
            catch
            {
                return new DataTable();
            }
        }
    }

    public class Utf8StringWriter : StringWriter
    {
        public override Encoding Encoding => Encoding.UTF8;
    }
}
