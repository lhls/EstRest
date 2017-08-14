USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_login]    Script Date: 08/13/2017 22:05:55 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_login]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_login]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_login]    Script Date: 08/13/2017 22:05:55 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[pr_login]
	@ds_usuario varchar(50),
	@ds_senha varchar(50)	
AS
BEGIN
	
	SET NOCOUNT ON;

    SELECT cd_usuario,
			'Sucesso' as ds_msg,
			cd_perfil
	from tb_usuario
	where ds_usuario = @ds_usuario
	and ds_senha = @ds_senha
	and fg_excluido = 0
	
	union
	
	SELECT  0 as cd_usuario,
			'Senha Inválida' as ds_msg,
			0 as cd_perfil
	from tb_usuario
	where ds_usuario = @ds_usuario
	and ds_senha <> @ds_senha
	and fg_excluido = 0
	
	union
	
	SELECT 0 as cd_usuario,
			'Login Inválido' as ds_msg,
			0 as cd_perfil
	from tb_usuario
	where ds_usuario <> @ds_usuario
	
END

GO

