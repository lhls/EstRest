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
    public partial class Ingrediente : cPaginaBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            titulo_pagina = "Ingredientes";
            base.Page_Load(sender, e);
        }

        protected override void carregarCombos()
        {
            nUnidadeMedida objUM = new nUnidadeMedida();
            //TODO: Carregar Unidades de Medida
            ddlUnidadeMedidaInclusao.DataSource = objUM.EfetuarConsulta();
            ddlUnidadeMedidaInclusao.DataBind();

            ddlUnidadeMedidaInclusao.Items.Insert(0, new ListItem("Selecione", int.MinValue.ToString()));
            ddlUnidadeMedidaInclusao.SelectedIndex = 0;
        }

        protected override void limpaCamposPesquisa()
        {
            txtDescricaoPesquisa.Value = string.Empty;
            ddlUnidadeMedidaInclusao.SelectedIndex = 0;
        }
        

        protected void btnConsultar_ServerClick(object sender, EventArgs e)
        {
            nIngrediente objIng = new nIngrediente
            {
                ds_ingrediente = txtDescricaoPesquisa.Value
            };

            DataSet ds = objIng.EfetuarConsulta();
            popularGrid(gvDados, ds.Tables[0]);
        }

        protected override void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            nIngrediente objIng = new nIngrediente
            {
                cd_ingrediente = (!string.IsNullOrEmpty(hdnCdIngrediente.Value) ? Convert.ToInt32(hdnCdIngrediente.Value) : int.MinValue),
                ds_ingrediente = txtDescricaoInclusao.Value,
                cd_unidade_medida = Convert.ToInt32(ddlUnidadeMedidaInclusao.SelectedValue),
            };
            if (objIng.cd_ingrediente == int.MinValue)
            {
                objIng.dt_validade = Convert.ToDateTime(txtDtValidade.Value);
                objIng.nr_quantidade_atual = Convert.ToDecimal(txtQtdInicial.Value);
            }
            try
            {
                objIng.EfetuarAtualizacao(c_cd_usuario_logado);
                ExibirMensagem("Efetuada Inclusao do Ingrediente " + objIng.ds_ingrediente + " com sucesso.");
            }
            catch (Exception ex)
            {
                throw ex;
            }

            base.btnSalvar_ServerClick(sender, e);
        }

        protected override void btnInserir_ServerClick(object sender, EventArgs e)
        {
            divValidadeInicial.Visible = true;
            divQuantidadeInicial.Visible = true;

            base.btnInserir_ServerClick(sender, e);
        }

        protected override void limpaCamposInclusao()
        {
            hdnCdIngrediente.Value = string.Empty;
            txtDescricaoInclusao.Value = string.Empty;
            txtDtValidade.Value = string.Empty;
            txtQtdInicial.Value = string.Empty;

            base.limpaCamposInclusao();
        }

        protected void gvDados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "EDITAR")
            {
                nIngrediente objIng = new nIngrediente((int)(((GridView)sender).DataKeys[Convert.ToInt32(e.CommandArgument)]).Value);

                v_place_holder_ativo = e_place_holder_ativo.Editar;

                hdnCdIngrediente.Value = objIng.cd_ingrediente.ToString();
                txtDescricaoInclusao.Value = objIng.ds_ingrediente;
                ddlUnidadeMedidaInclusao.SelectedValue = objIng.cd_unidade_medida.ToString();

                divValidadeInicial.Visible = false;
                divQuantidadeInicial.Visible = false;

            }
            else if (e.CommandName == "EXCLUIR")
            {
                nIngrediente objU = new nIngrediente
                {
                    cd_ingrediente = (int)(((GridView)sender).DataKeys[Convert.ToInt32(e.CommandArgument)]).Value,
                    fg_excluido = true
                };
                try
                {
                    objU.EfetuarExclusao(c_cd_usuario_logado);
                    ExibirMensagem("Efetuada exclusão do ingrediente " + objU.ds_ingrediente + " com sucesso.");

                    btnConsultar_ServerClick(null, null);
                }
                catch (Exception ex)
                {
                    if (!ExibirMensagemErro(ex.Message))
                    {
                        throw ex;
                    }
                }
            }
        }
    }
}