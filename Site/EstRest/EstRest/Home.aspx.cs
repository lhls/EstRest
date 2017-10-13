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
    public partial class Home : cPaginaBase
    {
        protected override void Page_Load(object sender, EventArgs e)
        {
            titulo_pagina = "Página inicial";
            v_oculta_place_holders = false;

            carregarDados();
        }

        private void carregarDados()
        {
            nEstoque obj = new nEstoque();

            DataTable dtDadosA = obj.consultarEstoquesProxVencimento();

            DataTable dtIngredientes = new DataTable();
            dtIngredientes.Columns.Add("cd_ingrediente");

            foreach(DataRow dtRow in dtDadosA.Rows)
            {
                litIngredientesValidade.Text += dtRow["ds_ingrediente"].ToString() + " - " + Convert.ToDateTime(dtRow["dt_validade"]).ToString("dd/MM/yyyy") + "<br />";

                if (dtIngredientes.Select("cd_ingrediente = " + dtRow["cd_ingrediente"].ToString()).Length == 0)
                {
                    dtIngredientes.Rows.Add(dtRow["cd_ingrediente"].ToString());
                }
            }

            foreach(DataRow dtRow in dtIngredientes.Rows)
            {
                nPrato objP = new nPrato();
                objP.cd_ingrediente_pesquisa = Convert.ToInt32(dtRow["cd_ingrediente"].ToString());
                DataTable dtPratos = objP.EfetuarConsulta().Tables[0];
                foreach (DataRow dtRowP in dtPratos.Rows)
                {
                    if (!litPratosSugeridos.Text.Contains(dtRowP["ds_prato"].ToString()))
                    {
                        litPratosSugeridos.Text += dtRowP["ds_prato"].ToString() + "<br />";
                    }
                }
            }
        }
    }
}