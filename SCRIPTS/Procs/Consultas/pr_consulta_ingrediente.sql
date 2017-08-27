USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_ingrediente]    Script Date: 08/27/2017 09:25:22 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_consulta_ingrediente]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_consulta_ingrediente]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_ingrediente]    Script Date: 08/27/2017 09:25:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[pr_consulta_ingrediente]
	@ds_ingrediente varchar(50) = NULL,
	@cd_ingrediente int = NULL

AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT cd_ingrediente,
			ds_ingrediente,
			i.cd_unidade_medida,
			um.ds_unidade_medida
	from tb_ingrediente i
	join tb_unidade_medida um
		on um.cd_unidade_medida = i.cd_unidade_medida
	where ds_ingrediente like ISNULL(@ds_ingrediente + '%', ds_ingrediente)
	and fg_excluido = 0
	and cd_ingrediente = ISNULL(@cd_ingrediente, cd_ingrediente)
	
	SET NOCOUNT OFF;
END


GO

