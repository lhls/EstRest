using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using System.Data;

namespace EstRest
{
    public partial class Usuario : cPaginaBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            titulo_pagina = "Usuários";
            base.Page_Load(sender, e);
        }

        protected override void carregarCombos()
        {
            ddlPerfilPesquisa.Items.Clear();
            ddlPerfilInclusao.Items.Clear();
            foreach (nUsuario.e_perfil item in Enum.GetValues(typeof(nUsuario.e_perfil)))
            {
                if (item == nUsuario.e_perfil.Selecione)
                {
                    ddlPerfilPesquisa.Items.Insert(0, new ListItem(Enum.GetName(typeof(nUsuario.e_perfil), item), ((int)item).ToString()));
                    ddlPerfilInclusao.Items.Insert(0, new ListItem(Enum.GetName(typeof(nUsuario.e_perfil), item), ((int)item).ToString()));
                }
                else
                {
                    ddlPerfilPesquisa.Items.Add(new ListItem(Enum.GetName(typeof(nUsuario.e_perfil), item), ((int)item).ToString()));
                    ddlPerfilInclusao.Items.Add(new ListItem(Enum.GetName(typeof(nUsuario.e_perfil), item), ((int)item).ToString()));
                }
            }
        }

        protected void btnConsultar_ServerClick(object sender, EventArgs e)
        {
            nUsuario objU = new nUsuario
            {
                cd_perfil = Convert.ToInt32(ddlPerfilPesquisa.SelectedValue),
                ds_nome = txtNomePesquisa.Value,
                v_login = txtLoginPesquisa.Value
            };

            DataSet ds = objU.EfetuarConsulta();
            popularGrid(gvDados, ds.Tables[0]);
        }

        protected void btnCancelar_ServerClick(object sender, EventArgs e)
        {
            v_place_holder_ativo = e_place_holder_ativo.Consultar;
            limpaCamposInclusao();
        }
        protected override void limpaCamposInclusao()
        {
            txtNomeInclusao.Value = string.Empty;
            txtLoginInclusao.Value = string.Empty;
            txtSenhaInclusao.Value = string.Empty;
            hdnCdUsuario.Value = string.Empty;

            base.limpaCamposInclusao();

        }
        protected override void limpaCamposPesquisa()
        {
            txtNomePesquisa.Value = string.Empty;
            ddlPerfilPesquisa.SelectedIndex = 0;
            txtLoginPesquisa.Value = string.Empty;

            ddlPerfilPesquisa.SelectedValue = ((int)nUsuario.e_perfil.Selecione).ToString();

            limparGrid(gvDados);
        }

        protected override void btnSalvar_ServerClick(object sender, EventArgs e)
        {

            nUsuario objU = new nUsuario
            {
                cd_usuario = (!string.IsNullOrEmpty(hdnCdUsuario.Value) ? Convert.ToInt32(hdnCdUsuario.Value) : int.MinValue),
                cd_perfil = Convert.ToInt32(ddlPerfilInclusao.SelectedValue),
                ds_nome = txtNomeInclusao.Value,
                v_login = txtLoginInclusao.Value,
                v_senha = txtSenhaInclusao.Value
            };

            try
            {
                objU.EfetuarAtualizacao(c_cd_usuario_logado);
                ExibirMensagem("Efetuada Inclusao do usuário " + objU.v_login + " com sucesso.");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            base.btnSalvar_ServerClick(sender, e);
        }

        protected void gvDados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EDITAR")
            {
                nUsuario objU = new nUsuario((int)(((GridView)sender).DataKeys[Convert.ToInt32(e.CommandArgument)]).Value);

                v_place_holder_ativo = e_place_holder_ativo.Editar;
                
                txtNomeInclusao.Value = objU.ds_nome;
                txtLoginInclusao.Value = objU.v_login;
                txtSenhaInclusao.Value = objU.v_senha;
                hdnCdUsuario.Value = objU.cd_usuario.ToString();
                ddlPerfilInclusao.SelectedValue = objU.cd_perfil.ToString();

            }
            else if (e.CommandName == "EXCLUIR")
            {
                nUsuario objU = new nUsuario
                {
                    cd_usuario = (int)(((GridView)sender).DataKeys[Convert.ToInt32(e.CommandArgument)]).Value,
                    fg_excluido = true
                };
                if (objU.cd_usuario == c_cd_usuario_logado)
                    ExibirMensagem("Não é possível excluir o usuário que está logado.");
                else
                {
                    try
                    {
                        objU.EfetuarAtualizacao(c_cd_usuario_logado);
                        ExibirMensagem("Efetuada exclusão do usuário " + objU.v_login + " com sucesso.");

                        btnConsultar_ServerClick(null, null);
                    }
                    catch (Exception ex)
                    {
                        throw ex;
                    }
                }
            }
        }
    }
}