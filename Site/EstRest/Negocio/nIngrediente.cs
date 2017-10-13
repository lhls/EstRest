using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Negocio
{
    public class nIngrediente : NegocioBase, iNegocioBase
    {
        public int cd_ingrediente { get; set; }
        public string ds_ingrediente { get; set; }
        public int cd_unidade_medida { get; set; }
        public DateTime dt_validade { get; set; }
        public decimal nr_quantidade_atual { get; set; }
        public bool fg_excluido { get; set; }

        public override void inicializaVariaveis()
        {
            pr_atualiza = "pr_atualiza_ingrediente";
            pr_consulta = "pr_consulta_ingrediente";

            base.inicializaVariaveis();
        }

        public nIngrediente()
        {
            inicializaVariaveis();
        }

        public nIngrediente(int id)
        {
            inicializaVariaveis();
            Carregar(id);
        }
        public void Carregar(int id)
        {
            DataTable dt = ConsultaDataTable(pr_consulta, new object[] { null, id });
            if (dt.Rows.Count > 0)
            {
                this.cd_ingrediente = (int)dt.Rows[0]["cd_ingrediente"];
                this.cd_unidade_medida = (int)dt.Rows[0]["cd_unidade_medida"];
                this.ds_ingrediente = dt.Rows[0]["ds_ingrediente"].ToString();
            }
        }

        public DataSet EfetuarConsulta() { return consultarItem(); }
        private DataSet consultarItem()
        {
            return ConsultaDataSet(pr_consulta, new object[] { ds_ingrediente, null });
        }

        public int EfetuarExclusao(int cd_usuario_logado)
        {
            return AtualizaDados(pr_atualiza, this, cd_usuario_logado, true);
        }
        
    }
}
