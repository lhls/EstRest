USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_usuario]    Script Date: 08/20/2017 19:31:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_consulta_usuario]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_consulta_usuario]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_consulta_usuario]    Script Date: 08/20/2017 19:31:42 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pr_consulta_usuario]
	@ds_usuario varchar(50),
	@ds_nome varchar(50),
	@cd_perfil int,
	@cd_usuario int = NULL

AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT cd_usuario,
			ds_usuario,
			ds_senha,
			ds_nome,
			cd_perfil
	from tb_usuario
	where ds_usuario like ISNULL(@ds_usuario + '%', ds_usuario)
	and ds_nome LIKE ISNULL(@ds_nome + '%', ds_nome)
	and cd_perfil = ISNULL(@cd_perfil, cd_perfil)
	and fg_excluido = 0
	and cd_usuario = ISNULL(@cd_usuario, cd_usuario)
	
END

GO

