using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace EstRest
{
    interface iPaginaBase
    {
        string c_chave_criptografia { get; }
        int c_cd_usuario_logado { get; }
        int c_cd_perfil { get; }
        string titulo_pagina { get; set; }
        int v_place_holder_ativo { get; set; }
        bool v_oculta_place_holders { set; }
    }
}
