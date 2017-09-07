USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_estoque_movimentacao]    Script Date: 08/30/2017 20:59:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_consulta_estoque_movimentacao]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_consulta_estoque_movimentacao]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_estoque_movimentacao]    Script Date: 08/30/2017 20:59:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		Luiz Lira
-- Create date: 28-08-2017
-- Description:	Procedure de consulta da movimentação do estoque
-- =============================================
CREATE PROCEDURE [dbo].[pr_consulta_estoque_movimentacao] 
	-- Add the parameters for the stored procedure here
	@dt_validade datetime = null,
	@cd_estoque int = null,
	@cd_estoque_movimentacao int = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT em.cd_estoque_movimentacao,
			e.cd_estoque,
			i.cd_ingrediente,
			i.ds_ingrediente,
			u.ds_nome as ds_usuario_alteracao,
			CONVERT(VARCHAR(10),e.dt_validade, 103) dt_validade,
			em.dt_lancamento as dt_alteracao,
			em.nr_quantidade,
			em.fg_entrada
	from tb_estoque_movimentacao em
	join tb_estoque e
		on e.cd_estoque = em.cd_estoque
	join tb_ingrediente i
		on i.cd_ingrediente = e.cd_ingrediente
	join tb_usuario u 
		on u.cd_usuario = em.cd_usuario_lancamento
	where e.cd_estoque = ISNULL(@cd_estoque, e.cd_estoque)
	AND e.dt_validade = ISNULL(@dt_validade, e.dt_validade)
	AND em.cd_estoque_movimentacao = ISNULL(@cd_estoque_movimentacao, em.cd_estoque_movimentacao)
	ORDER BY em.dt_lancamento DESC
	
	SET NOCOUNT off;
END



GO

