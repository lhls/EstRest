using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Negocio
{
    public class nEstoque : NegocioBase, iNegocioBase
    {
        public int cd_estoque { get; set; }
        public int cd_ingrediente { get; set; }
        public string ds_ingrediente { get; set; }//usada na consulta
        public DateTime dt_validade { get; set; }
        public DateTime dt_validade_inicial { get; set; }//usada na consulta
        public DateTime dt_validade_final { get; set; }//usada na consulta
        public decimal nr_quantidade_atual { get; set; }
        public decimal nr_quantidade_alterar { get; set; }
        public bool fg_entrada { get; set; }
        public List<nEstoqueMovimentacao> lst_estoque_movimentacao { get; set; }

        public nEstoque()
        {
            inicializaVariaveis();
        }

        public nEstoque(int id, DateTime dt)
        {
            inicializaVariaveis();

            Carregar(id, dt);
        }

        public override void inicializaVariaveis()
        {
            pr_atualiza = "pr_atualiza_estoque";
            pr_consulta = "pr_consulta_estoque";

            lst_estoque_movimentacao = new List<nEstoqueMovimentacao>();

            base.inicializaVariaveis();
        }

        public void Carregar(int id, DateTime dt)
        {
            DataSet ds = ConsultaDataSet(pr_consulta, new object[] { null, null, null, id, dt });
            try
            {
                DataRow dr = ds.Tables[0].Rows[0];

                this.cd_estoque = Convert.ToInt32(dr["cd_estoque"]);
                this.cd_ingrediente = Convert.ToInt32(dr["cd_ingrediente"]);
                this.ds_ingrediente = dr["ds_ingrediente"].ToString();
                this.dt_validade = Convert.ToDateTime(dr["dt_validade"]);
                this.nr_quantidade_atual = Convert.ToDecimal(dr["nr_quantidade_atual"]);

                foreach (DataRow dr1 in ds.Tables[1].Rows)
                {
                    nEstoqueMovimentacao objEM = new nEstoqueMovimentacao(Convert.ToInt32(dr1["cd_estoque_movimentacao"]));

                    lst_estoque_movimentacao.Add(objEM);
                }
            }
            catch (Exception)
            {
                throw new Exception("Erro ao carregar estoque");
            }
        }

        public DataSet EfetuarConsulta()
        {
            return consultarDados();
        }

        private DataSet consultarDados()
        {
            return ConsultaDataSet(pr_consulta, new object[] { ds_ingrediente, dt_validade_inicial, dt_validade_final, null, null });
        }

        public int EfetuarExclusao(int cd_usuario_logado)
        {
            throw new NotImplementedException();
        }

        public void Carregar(int id)
        {
            throw new NotImplementedException();
        }
    }
}
