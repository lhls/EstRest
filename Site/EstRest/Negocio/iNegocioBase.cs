﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;

namespace Negocio
{
    interface iNegocioBase
    {
        DataSet EfetuarConsulta(); 
    }
}
