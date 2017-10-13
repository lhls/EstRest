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
    public partial class Prato : cPaginaBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            titulo_pagina = "Pratos";
            base.Page_Load(sender, e);
        }

        protected override void limpaCamposPesquisa()
        {
            txtDescricaoPesquisa.Value = string.Empty;
            txtDescricaoIngredientePesquisa.Value = string.Empty;
        }

        protected void btnAdicionar_ServerClick(object sender, EventArgs e)
        {
            int i = 0;
            while (i < ddlIngredientesDisp.Items.Count)
            {
                ListItem lstI = ddlIngredientesDisp.Items[i];
                if (lstI.Selected)
                {
                    ddlIngredientesIncl.Items.Add(new ListItem(lstI.Text, lstI.Value));
                    ddlIngredientesDisp.Items.RemoveAt(i);
                }
                else
                    i++;
            }
        }
        protected void btnRemover_ServerClick(object sender, EventArgs e)
        {
            int i = 0;
            while (i < ddlIngredientesIncl.Items.Count)
            {
                ListItem lstI = ddlIngredientesIncl.Items[i];
                if (lstI.Selected)
                {
                    ddlIngredientesDisp.Items.Add(new ListItem(lstI.Text, lstI.Value));
                    ddlIngredientesIncl.Items.RemoveAt(i);
                }
                else
                    i++;
            }
        }

        protected void btnConsultar_ServerClick(object sender, EventArgs e)
        {
            nPrato objEst = new nPrato
            {
                ds_prato = txtDescricaoPesquisa.Value,
                ds_ingrediente_pesquisa = txtDescricaoIngredientePesquisa.Value
            };

            DataSet ds = objEst.EfetuarConsulta();
            popularGrid(gvDados, ds.Tables[0]);
        }

        protected override void btnInserir_ServerClick(object sender, EventArgs e)
        {
            carregarCombos();
            base.btnInserir_ServerClick(sender, e);
        }

        protected override void carregarCombos()
        {
            carregarIngredientesDisponiveis(int.MinValue);
            base.carregarCombos();
        }

        private void carregarIngredientesDisponiveis(int idPrato)
        {
            nIngrediente objConsTodos = new nIngrediente();
            DataTable dtSource = objConsTodos.EfetuarConsulta().Tables[0];
            if (idPrato != int.MinValue)
            {
                nPrato objConsulta = new nPrato(idPrato);
                int i = 0;
                while (i < dtSource.Rows.Count)
                {
                    foreach (nIngrediente objI in objConsulta.lst_ingredientes)
                    {
                        if (Convert.ToInt32(dtSource.Rows[i]["cd_ingrediente"]) == objI.cd_ingrediente)
                        {
                            dtSource.Rows.RemoveAt(i);
                            i--;
                            break;
                        }
                    }
                    i++;
                }
            }

            ddlIngredientesDisp.DataSource = dtSource;
            ddlIngredientesDisp.DataBind();
        }

        private void carregarIngredientesIncl(int idPrato)
        {
            nPrato objConsulta = new nPrato(idPrato);

            ddlIngredientesIncl.DataSource = objConsulta.lst_ingredientes;
            ddlIngredientesIncl.DataBind();
        }

        protected override void limpaCamposInclusao()
        {
            txtDescricaoInclusao.Value = string.Empty;
            ddlIngredientesDisp.Items.Clear();
            ddlIngredientesIncl.Items.Clear();
            hdnCdPrato.Value = string.Empty;

            base.limpaCamposInclusao();

        }

        protected override void btnSalvar_ServerClick(object sender, EventArgs e)
        {

            nPrato objP = new nPrato { ds_prato = txtDescricaoInclusao.Value };
            if (!string.IsNullOrEmpty(hdnCdPrato.Value))
                objP.cd_prato = Convert.ToInt32(hdnCdPrato.Value);

            foreach(ListItem lstIng in ddlIngredientesIncl.Items)
            {
                nIngrediente objI = new nIngrediente(Convert.ToInt32(lstIng.Value));
                objP.lst_ingredientes.Add(objI);
            }

            try
            {
                objP.EfetuarAtualizacao(c_cd_usuario_logado);
                ExibirMensagem("Efetuada gravação do prato " + objP.ds_prato + " com sucesso.");
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
                nPrato objP = new nPrato((int)(((GridView)sender).DataKeys[Convert.ToInt32(e.CommandArgument)]).Value);

                v_place_holder_ativo = e_place_holder_ativo.Editar;

                txtDescricaoInclusao.Value = objP.ds_prato;
                carregarIngredientesDisponiveis(objP.cd_prato);
                carregarIngredientesIncl(objP.cd_prato);
                hdnCdPrato.Value = objP.cd_prato.ToString();

            }
            else if (e.CommandName == "EXCLUIR")
            {
                nPrato objP = new nPrato
                {
                    cd_prato = (int)(((GridView)sender).DataKeys[Convert.ToInt32(e.CommandArgument)]).Value,
                    fg_excluido = true
                };

                try
                {
                    objP.EfetuarAtualizacao(c_cd_usuario_logado);
                    ExibirMensagem("Efetuada exclusão do prato " + objP.ds_prato + " com sucesso.");

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