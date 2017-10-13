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
        protected override void carregarCombos()
        {
            nIngrediente objI = new nIngrediente();
            ddlIngredienteInclusao.DataSource = objI.EfetuarConsulta().Tables[0];
            ddlIngredienteInclusao.DataBind();

            ddlIngredienteInclusao.Items.Insert(0, new ListItem("Selecione", int.MinValue.ToString()));
        }
        protected override void limpaCamposInclusao()
        {
            txtDtValidadeInclusao.Value = "";
            txtQtdInicial.Value = "";

            base.limpaCamposInclusao();
        }
        protected override void limpaCamposPesquisa()
        {
            txtDescricaoPesquisa.Value = string.Empty;
            txtDtValidadeInicio.Value = DateTime.Now.ToString("dd/MM/yyyy");
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
            int linhaAtual;

            if (int.TryParse(e.CommandArgument.ToString(), out linhaAtual))
            {
                nEstoque objE = new nEstoque((int)(((GridView)sender).DataKeys[linhaAtual]["cd_estoque"]),
                                              Convert.ToDateTime(((GridView)sender).DataKeys[linhaAtual]["dt_validade"]));
                if (e.CommandName == "EDITAR")
                {
                    v_place_holder_ativo = e_place_holder_ativo.Editar;

                    hNomeIngredienteValidade.InnerText = objE.ds_ingrediente + " - " + objE.dt_validade.ToString("dd/MM/yyyy");

                    preencherGridHistorico(objE);
                }
                else
                {
                    objE.fg_entrada = (e.CommandName == "ADICIONAR");

                    HtmlInputText txtQtdAlterar = (HtmlInputText)gvDados.Rows[linhaAtual].FindControl("txtQtdAlterar");
                    decimal qtd_alterar = string.IsNullOrEmpty(txtQtdAlterar.Value) ? 0 : Convert.ToDecimal(txtQtdAlterar.Value);
                    if (qtd_alterar > 0)
                    {
                        objE.nr_quantidade_alterar = qtd_alterar;
                        if (!objE.fg_entrada && objE.nr_quantidade_alterar > objE.nr_quantidade_atual)
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
                    else
                    {
                        ExibirMensagem("Favor informar quantidade para movimentar estoque");
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
            btnVoltar.Visible = gvHistorico.Visible = true;
            divInclusao.Visible = false;
            popularGrid(gvHistorico, dt);
        }

        protected override void btnInserir_ServerClick(object sender, EventArgs e)
        {
            btnVoltar.Visible = gvHistorico.Visible = false;
            divInclusao.Visible = true;

            hNomeIngredienteValidade.InnerText = "Inclusão de estoque com nova validade";

            base.btnInserir_ServerClick(sender, e);
        }

        protected override void btnSalvar_ServerClick(object sender, EventArgs e)
        {
            if (ddlIngredienteInclusao.SelectedValue == int.MinValue.ToString() ||
                string.IsNullOrWhiteSpace(txtDtValidadeInclusao.Value) ||
                string.IsNullOrWhiteSpace(txtQtdInicial.Value))
            {
                ExibirMensagem("Preencha todos os campos");
                return;
            }

            nEstoque objNovoEstoque = new nEstoque
            {
                cd_ingrediente = Convert.ToInt32(ddlIngredienteInclusao.SelectedValue),
                dt_validade = Convert.ToDateTime(txtDtValidadeInclusao.Value),
                nr_quantidade_atual = Convert.ToDecimal(txtQtdInicial.Value)
            };

            try
            {
                objNovoEstoque.EfetuarAtualizacao(c_cd_usuario_logado, true);
                base.btnSalvar_ServerClick(sender, e);
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