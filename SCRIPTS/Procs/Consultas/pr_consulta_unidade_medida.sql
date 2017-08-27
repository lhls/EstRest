USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_unidade_medida]    Script Date: 08/27/2017 09:14:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_consulta_unidade_medida]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_consulta_unidade_medida]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_unidade_medida]    Script Date: 08/27/2017 09:14:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Luiz Lira
-- Create date: 27-08-2017
-- Description:	Consulta unidade Medida
-- =============================================
CREATE PROCEDURE [dbo].[pr_consulta_unidade_medida] 
	-- Add the parameters for the stored procedure here
	@ds_unidade_medida varchar(100), 
	@cd_unidade_medida int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT cd_unidade_medida,
			ds_unidade_medida
	from tb_unidade_medida
	where ISNULL(@ds_unidade_medida, ds_unidade_medida) = ds_unidade_medida
	AND ISNULL(@cd_unidade_medida, cd_unidade_medida) = cd_unidade_medida
END

GO

