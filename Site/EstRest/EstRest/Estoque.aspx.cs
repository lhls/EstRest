using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Negocio;
using System.Data;
using System.Web.UI.HtmlControls;

namespace EstRest
{
    public partial class Estoque : cPaginaBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            titulo_pagina = "Estoque";
            base.Page_Load(sender, e);
        }

        protected override void limpaCamposPesquisa()
        {
            txtDescricaoPesquisa.Value = string.Empty;
            txtDtValidadeInicio.Value = string.Empty;
            txtDtValidadeFim.Value = string.Empty;
        }
        protected void btnConsultar_ServerClick(object sender, EventArgs e)
        {
            nEstoque objEst = new nEstoque
            {
                ds_ingrediente = txtDescricaoPesquisa.Value,
                dt_validade_inicial = (string.IsNullOrEmpty(txtDtValidadeInicio.Value) ? DateTime.MinValue : Convert.ToDateTime(txtDtValidadeInicio.Value)),
                dt_validade_final = (string.IsNullOrEmpty(txtDtValidadeFim.Value) ? DateTime.MinValue : Convert.ToDateTime(txtDtValidadeFim.Value))
            };

            DataSet ds = objEst.EfetuarConsulta();
            popularGrid(gvDados, ds.Tables[0]);
        }
        protected void gvDados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            nEstoque objE = new nEstoque((int)(((GridView)sender).DataKeys[Convert.ToInt32(e.CommandArgument)]["cd_estoque"]),
                                                 Convert.ToDateTime(((GridView)sender).DataKeys[Convert.ToInt32(e.CommandArgument)]["dt_validade"]));

            if (e.CommandName == "EDITAR")
            {
                v_place_holder_ativo = e_place_holder_ativo.Editar;

                hNomeIngredienteValidade.InnerText = objE.ds_ingrediente + " - " + objE.dt_validade.ToString("dd/MM/yyyy");

                preencherGridHistorico(objE);
            }
            else
            {
                if (e.CommandName == "ADICIONAR")
                {
                    objE.fg_entrada = true;
                }
                else if (e.CommandName == "REMOVER") 
                {
                    objE.fg_entrada = false;
                }
                int linhaAtual = Convert.ToInt32(e.CommandArgument);
                HtmlInputText txtQtdAlterar = (HtmlInputText)gvDados.Rows[linhaAtual].FindControl("txtQtdAlterar");
                decimal qtd_alterar = string.IsNullOrEmpty(txtQtdAlterar.Value) ? 0 : Convert.ToDecimal(txtQtdAlterar.Value);

                objE.nr_quantidade_alterar = qtd_alterar;
                if (objE.nr_quantidade_alterar > objE.nr_quantidade_atual)
                {
                    ExibirMensagem("Não foi possível realizar remoção, pois produto possui apenas " + objE.nr_quantidade_atual.ToString() + " em estoque");
                }
                else
                {
                    try
                    {

                        objE.EfetuarAtualizacao(c_cd_usuario_logado);
                        ExibirMensagem("Efetuada " + (e.CommandName == "ADICIONAR" ? "inclusão" : "remoção") +
                                        " de estoque do ingrediente " + objE.ds_ingrediente + " com sucesso.");

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

        private void preencherGridHistorico(nEstoque objE)
        {
            DataTable dt = new DataTable();

            dt.Columns.Add("ds_ingrediente");
            dt.Columns.Add("nr_quantidade", typeof(decimal));
            dt.Columns.Add("ds_tipo_alteracao");
            dt.Columns.Add("ds_usuario_alteracao");
            dt.Columns.Add("dt_alteracao");

            foreach (nEstoqueMovimentacao objEM in objE.lst_estoque_movimentacao)
            {
                dt.Rows.Add(objEM.ds_ingrediente,
                            objEM.nr_quantidade.ToString("0.00"),
                            (objEM.fg_entrada ? "+" : "-"),
                            objEM.ds_usuario_alteracao,
                            objEM.dt_alteracao);
            }

            popularGrid(gvHistorico, dt);
        }
    }
}