using Conexao;
using System;
using System.Data;

namespace Negocio
{
    public class nUsuario : NegocioBase, iNegocioBase
    {
        public int cd_usuario { get; set; }
        public string v_login { get; set; }
        public string v_senha { get; set; }
        public string ds_nome { get; set; }
        public int cd_perfil { get; set; }
        public bool fg_excluido { get; set; }

        public enum e_perfil
        {
            Selecione = int.MinValue,
            Administrador = 1,
            Usuario = 2
        }

        private const string pr_login = "pr_login";
        private const string pr_consulta_usuario = "pr_consulta_usuario";
        private const string pr_inclui_usuario = "pr_inclui_usuario";
        public nUsuario()
        {
            cd_usuario = int.MinValue;
            cd_perfil = (int)e_perfil.Selecione;
        }

        public nUsuario(int id)
        {
            Carregar(id);
        }

        public DataSet EfetuarConsulta() { return consultarUsuario(); }
        public void Carregar(int id)
        {
            DataTable dt = ConsultaDataTable(pr_consulta_usuario, new object[] { null, null, null, id });
            if (dt.Rows.Count > 0)
            {
                this.cd_usuario = (int)dt.Rows[0]["cd_usuario"];
                this.cd_perfil = (int)dt.Rows[0]["cd_perfil"];
                this.ds_nome = dt.Rows[0]["ds_nome"].ToString();
                this.v_login = dt.Rows[0]["ds_usuario"].ToString();
                this.v_senha = dt.Rows[0]["ds_senha"].ToString();
            }
        }

        private DataSet consultarUsuario()
        {
            return ConsultaDataSet(pr_consulta_usuario, new object[] { v_login, ds_nome, cd_perfil, null });
        }

        public DataSet Login()
        {
            return ConsultaDataSet(pr_login, new object[] { v_login, v_senha});
        }

        public int EfetuarAtualizacao(int cd_usuario_logado)
        {
            return AtualizaDados(pr_inclui_usuario, this, cd_usuario_logado);
        }

        public int EfetuarExclusao(int cd_usuario_logado)
        {
            throw new NotImplementedException();
        }
    }
}
