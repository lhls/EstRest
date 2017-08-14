using Conexao;
using System;
using System.Configuration;
using System.Data;

namespace Negocio
{
    public class NegocioBase
    {
        public static string v_str_conexao
        {
            get
            {
                return ConfigurationManager.AppSettings["connection_string"];
            }
        }

        public static object[] CarregaParametrosNulos(object[] arrParm)
        {
            for (int i = 0; i < arrParm.Length; i++)
            {
                switch (arrParm[i].GetType().ToString())
                {
                    case ("System.String"):
                        if (String.IsNullOrEmpty(arrParm[i].ToString())) arrParm[i]= DBNull.Value;
                        break;
                    case ("System.Int32"):
                        if(Convert.ToInt32(arrParm[i]) == int.MinValue)arrParm[i] = DBNull.Value;
                        break;
                    default:
                        break;
                }
            }

            return arrParm;
        }

        protected static DataSet ConsultaDataSet(string nomeProc, object[] parametros)
        {
            try
            {
                return SqlHelper.ExecuteDataset(v_str_conexao, nomeProc, CarregaParametrosNulos(parametros));
            }
            catch
            {
                return new DataSet();
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
}
