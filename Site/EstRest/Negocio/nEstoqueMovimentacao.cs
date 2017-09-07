using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Negocio
{
    public class nEstoqueMovimentacao : NegocioBase, iNegocioBase
    {
        public int cd_estoque_movimentacao { get; set; }
        public int cd_estoque { get; set; }
        public int cd_ingrediente { get; set; }
        public string ds_ingrediente { get; set; }
        public string ds_usuario_alteracao { get; set; }
        public DateTime dt_validade { get; set; }
        public DateTime dt_alteracao { get; set; }
        public decimal nr_quantidade { get; set; }
        public bool fg_entrada { get; set; }

        public nEstoqueMovimentacao()
        {
            inicializaVariaveis();
        }
        public nEstoqueMovimentacao(int id)
        {
            inicializaVariaveis();

            Carregar(id);
        }

        public override void inicializaVariaveis()
        {
            pr_consulta = "pr_consulta_estoque_movimentacao";

            base.inicializaVariaveis();
        }
        public void Carregar(int id)
        {
            DataSet ds = ConsultaDataSet(pr_consulta, new object[] { null, null, id });
            try
            {
                DataRow dr = ds.Tables[0].Rows[0];

                this.cd_estoque_movimentacao = Convert.ToInt32(dr["cd_estoque_movimentacao"]);
                this.cd_estoque = Convert.ToInt32(dr["cd_estoque"]);
                this.cd_ingrediente = Convert.ToInt32(dr["cd_ingrediente"]);
                this.ds_ingrediente = dr["ds_ingrediente"].ToString();
                this.ds_usuario_alteracao = dr["ds_usuario_alteracao"].ToString();
                this.dt_validade = Convert.ToDateTime(dr["dt_validade"]);
                this.dt_alteracao = Convert.ToDateTime(dr["dt_alteracao"]);
                this.nr_quantidade = Convert.ToDecimal(dr["nr_quantidade"]);
                this.fg_entrada = Convert.ToBoolean(dr["fg_entrada"]);
                
            }
            catch (Exception)
            {
                throw new Exception("Erro ao carregar movimentação de estoque");
            }
        }

        public DataSet EfetuarConsulta()
        {
            return consultarDados();
        }

        private DataSet consultarDados()
        {
            return ConsultaDataSet(pr_consulta, new object[] { dt_validade, cd_estoque, null });
        }

        public int EfetuarExclusao(int cd_usuario_logado)
        {
            throw new NotImplementedException();
        }
    }
}
