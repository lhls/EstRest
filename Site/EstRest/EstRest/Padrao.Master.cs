using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.Configuration;
using Negocio;
using System.Data;

namespace EstRest
{
    public partial class Padrao : MasterPage, iPaginaBase
    {
        public enum e_place_holder_ativo
        {
            Consultar = 0,
            Editar = 1
        }

        public int c_cd_usuario_logado
        {
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
        public string TituloMasterPage { get; set; }
        public string titulo_pagina
        {
            get
            {
                return hTituloPagina.InnerText;
            }

            set
            {
                hTituloPagina.InnerText = value;
            }
        }
        public int v_place_holder_ativo
        {
            get
            {
                if (cphConsulta.Visible)
                    return (int)e_place_holder_ativo.Consultar;
                if (cphEdita.Visible)
                    return (int)e_place_holder_ativo.Consultar;

                return (int)e_place_holder_ativo.Consultar;
            }
            set
            {
                cphConsulta.Visible = false;
                cphEdita.Visible = false;

                switch (value)
                {
                    case (int)e_place_holder_ativo.Consultar:
                        cphConsulta.Visible = true;
                        break;
                    case (int)e_place_holder_ativo.Editar:
                        cphEdita.Visible = true;
                        break;
                    default:
                        cphConsulta.Visible = true;
                        break;
                }
            }
        }

        public bool v_oculta_place_holders { set { if (!value) divDadosMaster.Visible = false; } }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (c_cd_usuario_logado == 0)
            {
                string paginaRetorno = Encrypt.EncryptString(Request.Path, c_chave_criptografia);
                Response.Redirect("Login.aspx?ds_pagina=" + paginaRetorno);
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            CarregaMenu();
            if (!IsPostBack)
            {
                v_place_holder_ativo = (int)e_place_holder_ativo.Consultar;
            }
        }

        private void CarregaMenu()
        {
            DataTable dt = new DataTable();
            //TODO: Incluir datatable com os menus
            //nMenu.EfetuarConsulta(c_cd_usuario_logado);

            dt.Columns.Add("cd_menu");
            dt.Columns.Add("ds_nome");
            dt.Columns.Add("ds_url");
            dt.Columns.Add("cd_pai");

            PopulaMenus(dt);

            MontaMenu(dt);
        }

        private void PopulaMenus(DataTable dt)
        {
            dt.Rows.Add(1, //cd_menu
                        "Usuários", //ds_nome
                        "Usuario.aspx", //ds_url
                        0); //cd_pai
            dt.Rows.Add(2, //cd_menu
                        "Ingredientes", //ds_nome
                        "Ingrediente.aspx", //ds_url
                        0); //cd_pai
        }

        private void MontaMenu(DataTable dt)
        {
            foreach (DataRow dr in dt.Rows)
            {
                HtmlGenericControl liMenuPai = new HtmlGenericControl("li");
                HtmlAnchor aMenuPai = new HtmlAnchor();

                aMenuPai.HRef = ResolveUrl("~") + dr["ds_url"].ToString();
                aMenuPai.InnerText = dr["ds_nome"].ToString();

                DataRow[] drArray = dt.Select("cd_pai=" + dr["cd_menu"].ToString());
                //Verifica se menu atual é pai de algum menu para atribuir CSS
                // e montar o layout dos filhos
                if (drArray.Length > 0)
                {
                    HtmlGenericControl spn = new HtmlGenericControl("span");
                    spn.Attributes["class"] = "caret";

                    aMenuPai.Attributes["class"] = "dropdown-toggle";
                    aMenuPai.Attributes["data-toggle"] = "dropdown";
                    aMenuPai.HRef = "#";
                    aMenuPai.Controls.Add(spn);

                    HtmlGenericControl ulFilhos = new HtmlGenericControl("ul");
                    foreach (DataRow d in drArray)
                    {
                        HtmlAnchor aMenuFilho = new HtmlAnchor();
                        aMenuFilho.HRef = ResolveUrl("~") + d["ds_url"].ToString();
                        aMenuFilho.InnerText = d["ds_nome"].ToString();

                        HtmlGenericControl liMenuFilho = new HtmlGenericControl("li");
                        liMenuFilho.Controls.Add(aMenuFilho);

                        ulFilhos.Attributes["class"] = "dropdown-menu";
                        ulFilhos.Controls.Add(liMenuFilho);
                    }

                    liMenuPai.Attributes["class"] = "dropdown";
                    liMenuPai.Controls.Add(aMenuPai);
                    liMenuPai.Controls.Add(ulFilhos);
                }
                else
                {
                    //Se for o menu raiz adiciona ao anterior
                    if (Convert.ToInt32(dr["cd_pai"]) == 0) liMenuPai.Controls.Add(aMenuPai);
                }
                ulMenu.Controls.Add(liMenuPai);
            }
        }

        protected void btnLogOut_ServerClick(object sender, EventArgs e)
        {
            Session.Clear();
#if DEBUG
            Response.Redirect("/Login.aspx");
#else
            Response.Redirect(Request.ApplicationPath + "/Login.aspx");
#endif
        }
    }
}