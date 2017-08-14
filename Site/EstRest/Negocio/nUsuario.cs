using Conexao;
using System;
using System.Data;

namespace Negocio
{
    public class nUsuario : NegocioBase, iNegocioBase
    {
        public string v_login { get; set; }
        public string v_senha { get; set; }

        private const string pr_login = "pr_login";
        public DataSet EfetuarConsulta() { return login(); }

        private DataSet login()
        {
            return ConsultaDataSet(pr_login, new object[] { v_login, v_senha});
        }
    }
}
