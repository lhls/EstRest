USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_estoque]    Script Date: 08/30/2017 21:09:09 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_consulta_estoque]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_consulta_estoque]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_estoque]    Script Date: 08/30/2017 21:09:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Luiz Lira
-- Create date: 28-08-2017
-- Description:	Procedure de consulta do estoque
-- =============================================
CREATE PROCEDURE [dbo].[pr_consulta_estoque] 
	-- Add the parameters for the stored procedure here
	@ds_ingrediente varchar(100) = null, 
	@dt_validade_inicial datetime = null,
	@dt_validade_final datetime = null,
	@cd_estoque int = null,
	@dt_validade datetime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT e.cd_estoque,
			i.cd_ingrediente,
			CONVERT(VARCHAR(10),e.dt_validade, 103) dt_validade,
			e.nr_quantidade_atual,
			i.ds_ingrediente
	from tb_estoque e
	join tb_ingrediente i
		on i.cd_ingrediente = e.cd_ingrediente
	where ds_ingrediente like isnull(@ds_ingrediente + '%', ds_ingrediente)
	AND e.dt_validade >= isnull(@dt_validade_inicial, e.dt_validade) 
	AND e.dt_validade <= isnull(@dt_validade_final, e.dt_validade)
	AND e.cd_estoque = ISNULL(@cd_estoque, e.cd_estoque)
	AND i.fg_excluido = 0
	ORDER BY i.ds_ingrediente
	
	SELECT cd_estoque_movimentacao
	FROM tb_estoque e
	JOIN tb_estoque_movimentacao em
		on e.cd_estoque = em.cd_estoque
	join tb_ingrediente i
		on i.cd_ingrediente = e.cd_ingrediente
	WHERE e.cd_estoque = ISNULL(@cd_estoque, e.cd_estoque)
	AND dt_validade = ISNULL(@dt_validade, e.dt_validade)
	AND i.fg_excluido = 0
	ORDER BY em.cd_estoque_movimentacao desc
	
	SET NOCOUNT off;
END

GO

