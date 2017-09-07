USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_atualiza_estoque]    Script Date: 08/30/2017 18:40:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pr_atualiza_estoque]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pr_atualiza_estoque]
GO

USE [DbRestaurante]
GO

/****** Object:  StoredProcedure [dbo].[pr_atualiza_estoque]    Script Date: 08/30/2017 18:40:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Luiz Lira
-- Create date: 28-08-2017
-- Description:	Atualiza estoque
-- =============================================
CREATE PROCEDURE [dbo].[pr_atualiza_estoque] 
	-- Add the parameters for the stored procedure here
	@ds_xml varchar(max), 
	@cd_usuario_alteracao int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @erro VARCHAR(500) = NULL
	DECLARE @xml XML
	DECLARE @cd_ingrediente INT
	
    set @xml = CONVERT(xml, @ds_xml)
    
    BEGIN TRAN
    
    --Insere na movimentação
    
    DECLARE @estoque_movimentacao INT
	
	INSERT INTO tb_estoque_movimentacao (cd_estoque,
										nr_quantidade,
										fg_entrada,
										dt_lancamento,
										cd_usuario_lancamento)
    select ent.value('./cd_estoque[1]', 'int') as cd_estoque,
			ent.value('./nr_quantidade_alterar[1]', 'numeric(18,2)') as nr_quantidade,
			ent.value('./fg_entrada[1]', 'bit'),
			GETDATE(),
			@cd_usuario_alteracao
	from @xml.nodes('./nEstoque') foo(ent)
		
	set @estoque_movimentacao = @@Identity
	--Atualiza
	
	update e
	set nr_quantidade_atual = nr_quantidade_atual + (CASE WHEN em.fg_entrada = 1 THEN
															nr_quantidade
														ELSE
															-nr_quantidade
														END)
	from tb_estoque e
	join tb_estoque_movimentacao em
		on em.cd_estoque = e.cd_estoque
	where em.cd_estoque_movimentacao = @estoque_movimentacao

	IF @@ERROR = 0
	BEGIN
		COMMIT TRAN
		
		select isnull(ent.value('./cd_estoque[1]', 'int'), @estoque_movimentacao), @estoque_movimentacao
		from @xml.nodes('./nEstoque') foo(ent)
	END
	ELSE
	BEGIN
		ROLLBACK TRAN
		
		IF (@erro IS NOT NULL)
			RAISERROR(@erro, 10, 1)
		ELSE
			SELECT 0
	END
END

GO

