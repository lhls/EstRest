using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Negocio
{
    interface iNegocioBase
    {
        DataSet EfetuarConsulta(); 
        void Carregar(int id); 
        int EfetuarAtualizacao(int cd_usuario_logado); 
        int EfetuarExclusao(int cd_usuario_logado);
    }
}
