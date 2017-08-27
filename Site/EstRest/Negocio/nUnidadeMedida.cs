using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Negocio
{
    public class nUnidadeMedida : NegocioBase, iNegocioBase
    {
        public int cd_unidade_medida { get; set; }
        public string ds_unidade_medida { get; set; }

        public override void inicializaVariaveis()
        {
            pr_consulta = "pr_consulta_unidade_medida";

            base.inicializaVariaveis();
        }
        public nUnidadeMedida()
        {
            inicializaVariaveis();
        }
        public void Carregar(int id)
        {
            DataTable dt = ConsultaDataTable(pr_consulta, new object[] { null, id });
            if (dt.Rows.Count > 0)
            {
                this.ds_unidade_medida = dt.Rows[0]["ds_unidade_medida"].ToString();
                this.cd_unidade_medida = (int)dt.Rows[0]["cd_unidade_medida"];
            }
        }

        public DataSet EfetuarConsulta()
        {
            return ConsultaDataSet(pr_consulta, new object[] { ds_unidade_medida, null });
        }

        public int EfetuarExclusao(int cd_usuario_logado)
        {
            throw new NotImplementedException();
        }
    }
}
