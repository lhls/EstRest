using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Negocio
{
    public class nPrato : NegocioBase, iNegocioBase
    {
        public int cd_prato { get; set; }
        public string ds_prato { get; set; }
        public string ds_ingrediente_pesquisa { get; set; }
        public int cd_ingrediente_pesquisa { get; set; }
        public bool fg_excluido { get; set; }
        public List<nIngrediente> lst_ingredientes { get; set; }

        public override void inicializaVariaveis()
        {
            pr_atualiza = "pr_atualiza_prato";
            pr_consulta = "pr_consulta_prato";

            cd_prato = int.MinValue;
            lst_ingredientes = new List<nIngrediente>();

            base.inicializaVariaveis();
        }

        public nPrato()
        {
            inicializaVariaveis();
        }

        public nPrato(int id)
        {
            inicializaVariaveis();
            Carregar(id);
        }

        public void Carregar(int id)
        {
            DataSet ds = ConsultaDataSet(pr_consulta, new object[] { null, null, null, id });
            try
            {
                DataRow dr = ds.Tables[0].Rows[0];

                this.cd_prato = (int)dr["cd_prato"];
                this.ds_prato = dr["ds_prato"].ToString();

                nIngrediente objI;
                foreach (DataRow dr1 in ds.Tables[1].Rows)
                {
                    objI = new nIngrediente { cd_ingrediente = Convert.ToInt32(dr1["cd_ingrediente"]), ds_ingrediente = dr1["ds_ingrediente"].ToString() };

                    lst_ingredientes.Add(objI);
                }
            }
            catch (Exception)
            {
                throw new Exception("Erro ao carregar prato");
            }
        }

        public DataSet EfetuarConsulta()
        {
            return consultarDados();
        }

        private DataSet consultarDados()
        {
            return ConsultaDataSet(pr_consulta, new object[] { ds_prato, ds_ingrediente_pesquisa, cd_ingrediente_pesquisa, null });
        }

        public int EfetuarExclusao(int cd_usuario_logado)
        {
            return AtualizaDados(pr_atualiza, this, cd_usuario_logado, true);
        }
    }
}
