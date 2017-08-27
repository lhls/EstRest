using System;
using Negocio;
using System.Data;

namespace EstRest
{
    public partial class Login : cPaginaBase
    {
        protected void btnAcessar_Click(object sender, EventArgs e)
        {
            nUsuario usuario = new nUsuario
            {
                v_login = txtLogin.Value,
                v_senha = txtSenha.Value
            };

            DataSet dsLogin = usuario.Login();

            if (dsLogin.Tables.Count > 0 && dsLogin.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(dsLogin.Tables[0].Rows[0]["cd_usuario"]) != 0)
                {
                    CarregaSessoes(dsLogin);
                    if (Request.QueryString["ds_pagina"] == null || string.IsNullOrEmpty(Request.QueryString["ds_pagina"].ToString()))
                        Response.Redirect("Home.aspx", true);
                    else
                        Response.Redirect(Encrypt.DecryptString(Request.QueryString["ds_pagina"].ToString(), c_chave_criptografia), true);
                }
                else
                {
                    lblErro.Visible = true;
                    lblErro.InnerText = dsLogin.Tables[0].Rows[0]["ds_msg"].ToString();
                }
            }
            else
            {
                lblErro.Visible = true;
                lblErro.InnerText = "Erro ao tentar efetuar login.";
            }

        }

        private void CarregaSessoes(DataSet dsLogin)
        {
            DataRow dr = dsLogin.Tables[0].Rows[0];
            Session["cdUsuarioLogado"] = dr["cd_usuario"];
            Session["cdPerfilUsuarioLogado"] = dr["cd_perfil"];
        }
    }
}