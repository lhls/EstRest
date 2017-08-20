using System;
using System.Configuration;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace EstRest
{
    public class cPaginaBase : Page, iPaginaBase
    {
        public enum e_place_holder_ativo
        {
            Consultar = 0,
            Editar = 1
        }

        public int c_cd_usuario_logado {
            get { return Session["cdUsuarioLogado"] == null ? 0 : Convert.ToInt32(Session["cdUsuarioLogado"]); } 
        }

        public int c_cd_perfil
        {
            get { return Session["cdPerfilUsuarioLogado"] == null ? 0 : Convert.ToInt32(Session["cdPerfilUsuarioLogado"]); }
        }

        public string c_chave_criptografia
        {
            get
            {
                return ConfigurationManager.AppSettings["chave_criptografia"];
            }
        }

        public string titulo_pagina
        {
            get { return ((iPaginaBase)this.Master).titulo_pagina; }
            set { ((iPaginaBase)this.Master).titulo_pagina = value; }
        }

        public e_place_holder_ativo v_place_holder_ativo
        {
            get { return (e_place_holder_ativo)((iPaginaBase)this.Master).v_place_holder_ativo; }
            set { ((iPaginaBase)this.Master).v_place_holder_ativo = (int)value; }
        }

        public bool v_oculta_place_holders 
        {
            set { ((iPaginaBase)this.Master).v_oculta_place_holders = value; }
        }

        protected DataTable dtDados {
            get { return (DataTable)ViewState["dtDados"]; }
            set { ViewState["dtDados"] = value; }
        }

        int iPaginaBase.v_place_holder_ativo
        {
            get
            {
                throw new NotImplementedException();
            }

            set
            {
                throw new NotImplementedException();
            }
        }

        protected void paginacaoGrid(object s, GridViewPageEventArgs e)
        {
            ((GridView)s).PageIndex = e.NewPageIndex;
            popularGrid((GridView)s);
        }
        protected void ordenacaoGrid(object s, GridViewSortEventArgs e)
        {
            dtDados.DefaultView.Sort = e.SortExpression + " " + GetSortDirection(e.SortExpression);
            popularGrid((GridView)s);

        }
        private string GetSortDirection(string column)
        {

            // By default, set the sort direction to ascending.
            string sortDirection = "ASC";

            // Retrieve the last column that was sorted.
            string sortExpression = ViewState["SortExpression"] as string;

            if (sortExpression != null)
            {
                // Check if the same column is being sorted.
                // Otherwise, the default value can be returned.
                if (sortExpression == column)
                {
                    string lastDirection = ViewState["SortDirection"] as string;
                    if ((lastDirection != null) && (lastDirection == "ASC"))
                    {
                        sortDirection = "DESC";
                    }
                }
            }

            // Save new values in ViewState.
            ViewState["SortDirection"] = sortDirection;
            ViewState["SortExpression"] = column;

            return sortDirection;
        }
        protected void popularGrid(GridView gv, DataTable dt)
        {
            dtDados = dt;
            popularGrid(gv);
        }

        protected void limparGrid(GridView gv)
        {
            dtDados = (new DataTable());
            popularGrid(gv);
        }

        private void popularGrid(GridView gv)
        {
            gv.DataSource = dtDados;
            gv.DataBind();
        }

        protected void ExibirMensagem(string msg, string nomeScript)
        {
            ClientScript.RegisterStartupScript(Page.GetType(), nomeScript, "alert('" + msg + "');", true);
        }

        protected void ExibirMensagem(string msg)
        {
            ExibirMensagem(msg, Guid.NewGuid().ToString());
        }
    }
}