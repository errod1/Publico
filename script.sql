USE [bdSatawi]
GO
/****** Object:  UserDefinedFunction [dbo].[Table2Class]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Function [dbo].[Table2Class](@TableName as varchar(100))
returns varchar(8000)
As
Begin

--declare @TableName sysname = 'TypeGame'
declare @Result varchar(max) = 'public class ' + @TableName + '
{'

select @Result = @Result + '
    public ' + ColumnType + NullableSign + ' ' + ColumnName + ' { get; set; }
'
from
(
    select 
        replace(col.name, ' ', '_') ColumnName,
        column_id ColumnId,
        case typ.name 
            when 'bigint' then 'long'
            when 'binary' then 'byte[]'
            when 'bit' then 'bool'
            when 'char' then 'string'
            when 'date' then 'DateTime'
            when 'datetime' then 'DateTime'
            when 'datetime2' then 'DateTime'
            when 'datetimeoffset' then 'DateTimeOffset'
            when 'decimal' then 'decimal'
            when 'float' then 'float'
            when 'image' then 'byte[]'
            when 'int' then 'int'
            when 'money' then 'decimal'
            when 'nchar' then 'string'
            when 'ntext' then 'string'
            when 'numeric' then 'decimal'
            when 'nvarchar' then 'string'
            when 'real' then 'double'
            when 'smalldatetime' then 'DateTime'
            when 'smallint' then 'short'
            when 'smallmoney' then 'decimal'
            when 'text' then 'string'
            when 'time' then 'TimeSpan'
            when 'timestamp' then 'DateTime'
            when 'tinyint' then 'byte'
            when 'uniqueidentifier' then 'Guid'
            when 'varbinary' then 'byte[]'
            when 'varchar' then 'string'
            else 'UNKNOWN_' + typ.name
        end ColumnType,
        case 
            when col.is_nullable = 1 and typ.name in ('bigint', 'bit', 'date', 'datetime', 'datetime2', 'datetimeoffset', 'decimal', 'float', 'int', 'money', 'numeric', 'real', 'smalldatetime', 'smallint', 'smallmoney', 'time', 'tinyint', 'uniqueidentifier') 
            --then '?' 
			then ''
            else '' 
        end NullableSign
    from sys.columns col
        join sys.types typ on
            col.system_type_id = typ.system_type_id AND col.user_type_id = typ.user_type_id
    where object_id = object_id(@TableName)
) t
order by ColumnId

set @Result = @Result  + '
}'

return @Result

end
GO
/****** Object:  Table [dbo].[Aplicacion]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aplicacion](
	[AplicacionID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AplicacionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Juego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Juego](
	[JuegoID] [int] IDENTITY(1,1) NOT NULL,
	[TipoJuegoID] [int] NOT NULL,
	[Nombre] [varchar](150) NULL,
	[Notas] [varchar](200) NULL,
	[FechaDesde] [datetime] NOT NULL,
	[FechaHasta] [datetime] NOT NULL,
	[NumeroSegmentos] [int] NOT NULL,
	[TotalPremios] [int] NOT NULL,
	[TotalPremiosDia] [int] NOT NULL,
	[TotalPremiosParticipante] [int] NOT NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
	[ColorImagen] [bit] NOT NULL,
	[TotalParticipantesDia] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JuegoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JuegoParticipanteOportunidades]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JuegoParticipanteOportunidades](
	[JuegoParticipanteOportunidadID] [int] IDENTITY(1,1) NOT NULL,
	[JuegoParticipantesID] [int] NOT NULL,
	[TipoPremioID] [int] NULL,
	[CodigoOportunidad] [varchar](10) NOT NULL,
	[FechaOportunidad] [datetime] NULL,
	[Monto] [numeric](10, 2) NULL,
	[Jugado] [bit] NOT NULL,
	[Ganador] [bit] NOT NULL,
	[Extorno] [bit] NOT NULL,
	[FechaJuego] [datetime] NULL,
	[FechaGanador] [datetime] NULL,
	[Ganara] [bit] NOT NULL,
	[Secuencia] [int] NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
	[FechaActualizacion] [datetime] NULL,
	[NombreTerminal] [varchar](20) NULL,
	[CodigoUsuario] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[JuegoParticipanteOportunidadID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JuegoParticipantes]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JuegoParticipantes](
	[JuegoParticipantesID] [int] IDENTITY(1,1) NOT NULL,
	[JuegoID] [int] NOT NULL,
	[ParticipanteID] [int] NOT NULL,
	[OpcionesJugar] [int] NOT NULL,
	[OpcionesJugadas] [int] NOT NULL,
	[Ganador] [bit] NOT NULL,
	[FechaGanador] [datetime] NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[JuegoParticipantesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[JuegoPremios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[JuegoPremios](
	[JuegoPremiosID] [int] IDENTITY(1,1) NOT NULL,
	[TipoPremioID] [int] NOT NULL,
	[JuegoID] [int] NOT NULL,
	[Secuencia] [int] NOT NULL,
	[Cantidad] [decimal](5, 0) NOT NULL,
	[Ganados] [decimal](5, 0) NOT NULL,
	[Notas] [varchar](200) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
	[TotalPremiosDia] [decimal](5, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[JuegoPremiosID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Log_Juego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Juego](
	[JuegoID] [int] NULL,
	[Campo] [sysname] NOT NULL,
	[ValorAnterior] [sql_variant] NULL,
	[ValorActual] [sql_variant] NULL,
	[Modificado] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogJuego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogJuego](
	[LogJuegoID] [int] IDENTITY(1,1) NOT NULL,
	[JuegoID] [int] NOT NULL,
	[Campo] [varchar](150) NULL,
	[ValorAnterior] [varchar](200) NULL,
	[ValorActual] [varchar](200) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogJuegoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogJuegoParticipantes]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogJuegoParticipantes](
	[LogJuegoParticipantesID] [int] IDENTITY(1,1) NOT NULL,
	[JuegoID] [int] NOT NULL,
	[ParticipanteID] [int] NOT NULL,
	[JuegoParticipanteOportunidadID] [int] NOT NULL,
	[Accion] [varchar](100) NULL,
	[Jugado] [bit] NOT NULL,
	[Ganado] [bit] NOT NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogJuegoParticipantesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogJuegoPremios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogJuegoPremios](
	[LogJuegoPremiosID] [int] IDENTITY(1,1) NOT NULL,
	[JuegoPremiosID] [int] NOT NULL,
	[Campo] [varchar](150) NULL,
	[ValorAnterior] [varchar](200) NULL,
	[ValorActual] [varchar](200) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogJuegoPremiosID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogUsuarios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogUsuarios](
	[LogUsuariosID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[Accion] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogUsuariosID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Participante]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Participante](
	[ParticipanteID] [int] IDENTITY(1,1) NOT NULL,
	[TipoDocumento] [varchar](3) NOT NULL,
	[NumeroDocumento] [varchar](10) NOT NULL,
	[CodigoContribuyente] [varchar](10) NOT NULL,
	[Nombres] [varchar](100) NULL,
	[ApellidoPaterno] [varchar](100) NULL,
	[ApellidoMaterno] [varchar](100) NULL,
	[Notas] [varchar](200) NULL,
	[TelefonoContacto] [varchar](50) NULL,
	[CorreoContacto] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ParticipanteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParticipantesDia]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParticipantesDia](
	[ParticipantesDiaID] [int] IDENTITY(1,1) NOT NULL,
	[JuegoID] [int] NOT NULL,
	[FechaJuego] [datetime] NULL,
	[TotalParticipante] [int] NOT NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PremioOtorgarAcumulado]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremioOtorgarAcumulado](
	[PremioOtorgarAcumuladoID] [int] IDENTITY(1,1) NOT NULL,
	[JuegoID] [int] NOT NULL,
	[TipoPremioID] [int] NOT NULL,
	[JuegoParticipantesID] [int] NULL,
	[NumeroParticipante] [int] NOT NULL,
	[FechaAsignado] [datetime] NULL,
	[Asignado] [bit] NOT NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PremioOtorgarDia]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PremioOtorgarDia](
	[PremioOtorgarDiaID] [int] IDENTITY(1,1) NOT NULL,
	[JuegoID] [int] NOT NULL,
	[TipoPremioID] [int] NOT NULL,
	[JuegoParticipantesID] [int] NULL,
	[NumeroParticipante] [int] NOT NULL,
	[FechaAsignado] [datetime] NULL,
	[Asignado] [bit] NOT NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NOT NULL,
	[FechaCreacion] [datetime] NOT NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolAplicaciones]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolAplicaciones](
	[RolAplicacionesID] [int] IDENTITY(1,1) NOT NULL,
	[RolID] [int] NOT NULL,
	[AplicacionID] [int] NOT NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RolAplicacionesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RolID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sample_Table]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sample_Table](
	[ContactID] [int] NULL,
	[Forename] [varchar](100) NULL,
	[Surname] [varchar](100) NULL,
	[Extn] [varchar](16) NULL,
	[Email] [varchar](100) NULL,
	[Age] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Sample_Table_Changes]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sample_Table_Changes](
	[ContactID] [int] NULL,
	[FieldName] [sysname] NOT NULL,
	[FieldValueWas] [sql_variant] NULL,
	[FieldValueIs] [sql_variant] NULL,
	[modified] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoJuego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoJuego](
	[TipoJuegoID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TipoJuegoID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoPremio]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoPremio](
	[TipoPremioID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](150) NULL,
	[Imagen] [varchar](50) NULL,
	[ImagenSlice] [varchar](50) NULL,
	[TextoSlice] [varchar](100) NULL,
	[ColorSlice] [varchar](8) NULL,
	[Notas] [varchar](200) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TipoPremioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UsuarioRoles]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UsuarioRoles](
	[UsuarioRolesID] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioID] [int] NOT NULL,
	[RolID] [int] NOT NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioRolesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[UsuarioID] [int] IDENTITY(1,1) NOT NULL,
	[Login] [varchar](20) NULL,
	[Clave] [varchar](200) NULL,
	[Nombre] [varchar](100) NULL,
	[Activo] [bit] NULL,
	[Usuario] [varchar](50) NULL,
	[FechaCreacion] [datetime] NULL,
	[UsuarioUltimaVez] [varchar](50) NULL,
	[FechaUltimaVez] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[UsuarioID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [JuegoParticipanteOportunidades_idx]    Script Date: 29/5/2018 7:09:04 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [JuegoParticipanteOportunidades_idx] ON [dbo].[JuegoParticipanteOportunidades]
(
	[JuegoParticipantesID] ASC,
	[CodigoOportunidad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [JuegoParticipantes_idx]    Script Date: 29/5/2018 7:09:04 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [JuegoParticipantes_idx] ON [dbo].[JuegoParticipantes]
(
	[JuegoID] ASC,
	[ParticipanteID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [Participante_idx]    Script Date: 29/5/2018 7:09:04 p. m. ******/
CREATE UNIQUE NONCLUSTERED INDEX [Participante_idx] ON [dbo].[Participante]
(
	[TipoDocumento] ASC,
	[NumeroDocumento] ASC,
	[CodigoContribuyente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Aplicacion] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Aplicacion] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Aplicacion] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT ((0)) FOR [NumeroSegmentos]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT ((0)) FOR [TotalPremios]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT ((0)) FOR [TotalPremiosDia]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT ((0)) FOR [TotalPremiosParticipante]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT ((0)) FOR [ColorImagen]
GO
ALTER TABLE [dbo].[Juego] ADD  DEFAULT ((0)) FOR [TotalParticipantesDia]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] ADD  DEFAULT ((0)) FOR [Jugado]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] ADD  DEFAULT ((0)) FOR [Ganador]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] ADD  DEFAULT ((0)) FOR [Extorno]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] ADD  DEFAULT ((0)) FOR [Ganara]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[JuegoParticipantes] ADD  DEFAULT ((0)) FOR [OpcionesJugar]
GO
ALTER TABLE [dbo].[JuegoParticipantes] ADD  DEFAULT ((0)) FOR [OpcionesJugadas]
GO
ALTER TABLE [dbo].[JuegoParticipantes] ADD  DEFAULT ((0)) FOR [Ganador]
GO
ALTER TABLE [dbo].[JuegoParticipantes] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[JuegoParticipantes] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[JuegoParticipantes] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[JuegoPremios] ADD  DEFAULT ((0)) FOR [Cantidad]
GO
ALTER TABLE [dbo].[JuegoPremios] ADD  DEFAULT ((0)) FOR [Ganados]
GO
ALTER TABLE [dbo].[JuegoPremios] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[JuegoPremios] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[JuegoPremios] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Log_Juego] ADD  DEFAULT (getdate()) FOR [Modificado]
GO
ALTER TABLE [dbo].[LogJuego] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[LogJuego] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[LogJuego] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[LogJuegoParticipantes] ADD  DEFAULT ((0)) FOR [Jugado]
GO
ALTER TABLE [dbo].[LogJuegoParticipantes] ADD  DEFAULT ((0)) FOR [Ganado]
GO
ALTER TABLE [dbo].[LogJuegoParticipantes] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[LogJuegoParticipantes] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[LogJuegoParticipantes] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[LogJuegoPremios] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[LogJuegoPremios] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[LogJuegoPremios] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[LogUsuarios] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[LogUsuarios] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[LogUsuarios] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Participante] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Participante] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Participante] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[ParticipantesDia] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[ParticipantesDia] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[PremioOtorgarDia] ADD  DEFAULT ((0)) FOR [Asignado]
GO
ALTER TABLE [dbo].[PremioOtorgarDia] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[PremioOtorgarDia] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[RolAplicaciones] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[RolAplicaciones] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[RolAplicaciones] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Roles] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Sample_Table_Changes] ADD  DEFAULT (getdate()) FOR [modified]
GO
ALTER TABLE [dbo].[TipoJuego] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoJuego] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[TipoJuego] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[TipoPremio] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[TipoPremio] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[TipoPremio] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[UsuarioRoles] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[UsuarioRoles] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[UsuarioRoles] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT ((1)) FOR [Activo]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT (suser_sname()) FOR [Usuario]
GO
ALTER TABLE [dbo].[Usuarios] ADD  DEFAULT (getdate()) FOR [FechaCreacion]
GO
ALTER TABLE [dbo].[Juego]  WITH CHECK ADD  CONSTRAINT [Juego_TipoJuego_FK] FOREIGN KEY([TipoJuegoID])
REFERENCES [dbo].[TipoJuego] ([TipoJuegoID])
GO
ALTER TABLE [dbo].[Juego] CHECK CONSTRAINT [Juego_TipoJuego_FK]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades]  WITH CHECK ADD  CONSTRAINT [JuegoParticipanteOportunidades_JuegoParticipantes_FK] FOREIGN KEY([JuegoParticipantesID])
REFERENCES [dbo].[JuegoParticipantes] ([JuegoParticipantesID])
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] CHECK CONSTRAINT [JuegoParticipanteOportunidades_JuegoParticipantes_FK]
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades]  WITH CHECK ADD  CONSTRAINT [JuegoParticipanteOportunidades_TipoPremio_FK] FOREIGN KEY([TipoPremioID])
REFERENCES [dbo].[TipoPremio] ([TipoPremioID])
GO
ALTER TABLE [dbo].[JuegoParticipanteOportunidades] CHECK CONSTRAINT [JuegoParticipanteOportunidades_TipoPremio_FK]
GO
ALTER TABLE [dbo].[JuegoParticipantes]  WITH CHECK ADD  CONSTRAINT [JuegoParticipantes_Juego_FK] FOREIGN KEY([JuegoID])
REFERENCES [dbo].[Juego] ([JuegoID])
GO
ALTER TABLE [dbo].[JuegoParticipantes] CHECK CONSTRAINT [JuegoParticipantes_Juego_FK]
GO
ALTER TABLE [dbo].[JuegoParticipantes]  WITH CHECK ADD  CONSTRAINT [JuegoParticipantes_Participante_FK] FOREIGN KEY([ParticipanteID])
REFERENCES [dbo].[Participante] ([ParticipanteID])
GO
ALTER TABLE [dbo].[JuegoParticipantes] CHECK CONSTRAINT [JuegoParticipantes_Participante_FK]
GO
ALTER TABLE [dbo].[JuegoPremios]  WITH CHECK ADD  CONSTRAINT [JuegoPremios_Juego_FK] FOREIGN KEY([JuegoID])
REFERENCES [dbo].[Juego] ([JuegoID])
GO
ALTER TABLE [dbo].[JuegoPremios] CHECK CONSTRAINT [JuegoPremios_Juego_FK]
GO
ALTER TABLE [dbo].[JuegoPremios]  WITH CHECK ADD  CONSTRAINT [JuegoPremios_TipoPremio_FK] FOREIGN KEY([TipoPremioID])
REFERENCES [dbo].[TipoPremio] ([TipoPremioID])
GO
ALTER TABLE [dbo].[JuegoPremios] CHECK CONSTRAINT [JuegoPremios_TipoPremio_FK]
GO
ALTER TABLE [dbo].[LogJuego]  WITH CHECK ADD  CONSTRAINT [LogJuego_Juego_FK] FOREIGN KEY([JuegoID])
REFERENCES [dbo].[Juego] ([JuegoID])
GO
ALTER TABLE [dbo].[LogJuego] CHECK CONSTRAINT [LogJuego_Juego_FK]
GO
ALTER TABLE [dbo].[LogJuegoParticipantes]  WITH CHECK ADD  CONSTRAINT [LogJuegoParticipantes__JuegoParticipanteOportunidad_FK] FOREIGN KEY([JuegoParticipanteOportunidadID])
REFERENCES [dbo].[JuegoParticipanteOportunidades] ([JuegoParticipanteOportunidadID])
GO
ALTER TABLE [dbo].[LogJuegoParticipantes] CHECK CONSTRAINT [LogJuegoParticipantes__JuegoParticipanteOportunidad_FK]
GO
ALTER TABLE [dbo].[LogJuegoParticipantes]  WITH CHECK ADD  CONSTRAINT [LogJuegoParticipantes_Juego_FK] FOREIGN KEY([JuegoID])
REFERENCES [dbo].[Juego] ([JuegoID])
GO
ALTER TABLE [dbo].[LogJuegoParticipantes] CHECK CONSTRAINT [LogJuegoParticipantes_Juego_FK]
GO
ALTER TABLE [dbo].[LogJuegoParticipantes]  WITH CHECK ADD  CONSTRAINT [LogJuegoParticipantes_Participante_FK] FOREIGN KEY([ParticipanteID])
REFERENCES [dbo].[Participante] ([ParticipanteID])
GO
ALTER TABLE [dbo].[LogJuegoParticipantes] CHECK CONSTRAINT [LogJuegoParticipantes_Participante_FK]
GO
ALTER TABLE [dbo].[LogJuegoPremios]  WITH CHECK ADD  CONSTRAINT [LogJuegoPremios_Juego_FK] FOREIGN KEY([JuegoPremiosID])
REFERENCES [dbo].[JuegoPremios] ([JuegoPremiosID])
GO
ALTER TABLE [dbo].[LogJuegoPremios] CHECK CONSTRAINT [LogJuegoPremios_Juego_FK]
GO
ALTER TABLE [dbo].[LogUsuarios]  WITH CHECK ADD  CONSTRAINT [LogUsuarios_Usuario_FK] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[LogUsuarios] CHECK CONSTRAINT [LogUsuarios_Usuario_FK]
GO
ALTER TABLE [dbo].[ParticipantesDia]  WITH CHECK ADD  CONSTRAINT [ParticipantesDia_Juego_FK] FOREIGN KEY([JuegoID])
REFERENCES [dbo].[Juego] ([JuegoID])
GO
ALTER TABLE [dbo].[ParticipantesDia] CHECK CONSTRAINT [ParticipantesDia_Juego_FK]
GO
ALTER TABLE [dbo].[PremioOtorgarDia]  WITH CHECK ADD  CONSTRAINT [PremioOtorgar_Juego_FK] FOREIGN KEY([JuegoID])
REFERENCES [dbo].[Juego] ([JuegoID])
GO
ALTER TABLE [dbo].[PremioOtorgarDia] CHECK CONSTRAINT [PremioOtorgar_Juego_FK]
GO
ALTER TABLE [dbo].[PremioOtorgarDia]  WITH CHECK ADD  CONSTRAINT [PremioOtorgar_JuegoParticipante_FK] FOREIGN KEY([JuegoParticipantesID])
REFERENCES [dbo].[JuegoParticipantes] ([JuegoParticipantesID])
GO
ALTER TABLE [dbo].[PremioOtorgarDia] CHECK CONSTRAINT [PremioOtorgar_JuegoParticipante_FK]
GO
ALTER TABLE [dbo].[PremioOtorgarDia]  WITH CHECK ADD  CONSTRAINT [PremioOtorgar_TipoPremio_FK] FOREIGN KEY([TipoPremioID])
REFERENCES [dbo].[TipoPremio] ([TipoPremioID])
GO
ALTER TABLE [dbo].[PremioOtorgarDia] CHECK CONSTRAINT [PremioOtorgar_TipoPremio_FK]
GO
ALTER TABLE [dbo].[RolAplicaciones]  WITH CHECK ADD  CONSTRAINT [RolAplicaciones_Aplicacion_FK] FOREIGN KEY([AplicacionID])
REFERENCES [dbo].[Aplicacion] ([AplicacionID])
GO
ALTER TABLE [dbo].[RolAplicaciones] CHECK CONSTRAINT [RolAplicaciones_Aplicacion_FK]
GO
ALTER TABLE [dbo].[RolAplicaciones]  WITH CHECK ADD  CONSTRAINT [RolAplicaciones_Rol_FK] FOREIGN KEY([RolID])
REFERENCES [dbo].[Roles] ([RolID])
GO
ALTER TABLE [dbo].[RolAplicaciones] CHECK CONSTRAINT [RolAplicaciones_Rol_FK]
GO
ALTER TABLE [dbo].[UsuarioRoles]  WITH CHECK ADD  CONSTRAINT [UsuarioRoles_Roles_FK] FOREIGN KEY([RolID])
REFERENCES [dbo].[Roles] ([RolID])
GO
ALTER TABLE [dbo].[UsuarioRoles] CHECK CONSTRAINT [UsuarioRoles_Roles_FK]
GO
ALTER TABLE [dbo].[UsuarioRoles]  WITH CHECK ADD  CONSTRAINT [UsuarioRoles_Usuario_FK] FOREIGN KEY([UsuarioID])
REFERENCES [dbo].[Usuarios] ([UsuarioID])
GO
ALTER TABLE [dbo].[UsuarioRoles] CHECK CONSTRAINT [UsuarioRoles_Usuario_FK]
GO
/****** Object:  StoredProcedure [dbo].[ActualizarJuego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarJuego] 
	@JuegoID int,
	@TipoJuegoID int,
    @Nombre varchar(150),
    @Notas  varchar(200),
    @FechaDesde   datetime,
    @FechaHasta  datetime,
    @NumeroSegmentos  int,
    @TotalPremios  int,
    @TotalPremiosDia int,
    @TotalPremiosParticipante int,
	@TotalParticipantesDia int,
    @Activo bit,
    @ColorImagen bit

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


UPDATE [dbo].[Juego]
   SET [TipoJuegoID] = @TipoJuegoID
      ,[Nombre] = @Nombre
      ,[Notas] = @Notas
      ,[FechaDesde] = @FechaDesde
      ,[FechaHasta] = @FechaHasta
      ,[NumeroSegmentos] = @NumeroSegmentos
      ,[TotalPremios] = @TotalPremios
      ,[TotalPremiosDia] = @TotalPremiosDia
      ,[TotalPremiosParticipante] = @TotalPremiosParticipante
	  ,TotalParticipantesDia = @TotalParticipantesDia
      ,[Activo] = @Activo
      ,[ColorImagen] = @ColorImagen
 WHERE JuegoID = @JuegoID;



	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarJuegoPremios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarJuegoPremios] 
	@JuegoPremiosID int,
	@JuegoID int,
	@TipoPremioID int,
    @Secuencia int,
	@Cantidad int,
	@TotalPremiosDia int

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


UPDATE [dbo].[JuegoPremios]
   SET [JuegoID] = @JuegoID
      ,[TipoPremioID] = @TipoPremioID
      ,[Secuencia] = @Secuencia
      ,[Cantidad] = @Cantidad 
	  ,TotalPremiosDia = @TotalPremiosDia
	  WHERE JuegoPremiosID = @JuegoPremiosID;



	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarParticipantesDia]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarParticipantesDia] 
	@JuegoID int,
	@Fecha Datetime
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin tran
if exists (select * from ParticipantesDia with (updlock,serializable) where JuegoID = @JuegoID and  FechaJuego = @Fecha)
begin
   update ParticipantesDia set TotalParticipante = TotalParticipante + 1
   where JuegoID = @JuegoID and  FechaJuego = @Fecha
end
else
begin
   insert into ParticipantesDia (JuegoID, FechaJuego,TotalParticipante)
   values (@JuegoID, @Fecha, 1)
   
end
commit tran
select TotalParticipante from ParticipantesDia where JuegoID = @JuegoID and  FechaJuego = @Fecha;


	
                 
	
END


print dbo.Table2Class('ParticipantesDia')
GO
/****** Object:  StoredProcedure [dbo].[ActualizarPremiosGanado]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ActualizarPremiosGanado] 
	@JuegoID int,
	@TipoPremioID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	update JuegoPremios set Ganados = Ganados + 1 
    WHERE JuegoID=  @JuegoID   AND TipoPremioID = @TipoPremioID
     AND Activo=1;
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarTelefonoCorreoParticipante]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarTelefonoCorreoParticipante] 
	@ParticipanteID int,
	@TelefonoContacto varchar(20),
	@CorreoContacto varchar(100)

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	  UPDATE Participante 
            SET TelefonoContacto= @TelefonoContacto,
            CorreoContacto = @CorreoContacto
            WHERE ParticipanteID= @ParticipanteID;
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarTipoPremio]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarTipoPremio] 
	@TipoPremioID int,
    @Nombre varchar(150),
	@Imagen varchar(50),
	@ImagenSlice varchar(50),
	@TextoSlice varchar(100),
	@ColorSlice varchar(8),
    @Notas  varchar(200)

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

UPDATE [dbo].[TipoPremio]
   SET [Nombre] = @Nombre
	  ,[Imagen] = @Imagen
	  ,[ImagenSlice] = @ImagenSlice
	  ,[TextoSlice] = @TextoSlice
	  ,[ColorSlice] = @ColorSlice	
      ,[Notas] = @Notas
 WHERE TipoPremioID = @TipoPremioID;
	
END
GO
/****** Object:  StoredProcedure [dbo].[ActualizarUsuario]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ActualizarUsuario] 
	@UsuarioID int,
	@Login varchar(20),
    @Clave varchar(200),
    @Nombre  varchar(100),
    @Activo bit
   
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


UPDATE [dbo].[Usuarios]
   SET [Login] = @Login
	   ,[Clave] = @Clave
	  ,[Nombre] = @Nombre
      ,[Activo] = @Activo
 WHERE UsuarioID = @UsuarioID;



	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[AcumularPremioOtorgado]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AcumularPremioOtorgado] 
	

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


INSERT INTO [dbo].[PremioOtorgarAcumulado]
           ([JuegoID]
           ,[TipoPremioID]
           ,[JuegoParticipantesID]
           ,[NumeroParticipante]
           ,[FechaAsignado]
           ,[Asignado]
           ,[Activo]
           ,[Usuario]
           ,[FechaCreacion]
           ,[UsuarioUltimaVez]
           ,[FechaUltimaVez])
     select
           JuegoID,
           TipoPremioID,
           JuegoParticipantesID,
           NumeroParticipante,
           FechaAsignado,
           Asignado,
		   Activo,
           Usuario,
           FechaCreacion,
           UsuarioUltimaVez,
           FechaUltimaVez
		   from PremioOtorgarDia


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[AsignarPremioOtorgado]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AsignarPremioOtorgado] 
	@JuegoID int,
	@NumeroParticipante int,
	@JuegoParticipantesID int

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


UPDATE [dbo].[PremioOtorgarDia]
   SET [Asignado] = 1
      ,[FechaAsignado] = getdate(),
	  JuegoParticipantesID = @JuegoParticipantesID
 WHERE JuegoID = @JuegoID and NumeroParticipante = @NumeroParticipante;



	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarJuego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarJuego] 
	@JuegoID int

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


delete from Juego where JuegoID=@JuegoID


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarJuegoPremios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarJuegoPremios] 
	@JuegoPremiosID int

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


delete from JuegoPremios where JuegoPremiosID=@JuegoPremiosID


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarPremiosOtorgadosDia]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarPremiosOtorgadosDia] 
	

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

delete from PremioOtorgarDia 
	
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarTipoPremio]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarTipoPremio] 
	@TipoPremioID int

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
delete from TipoPremio where TipoPremioID=@TipoPremioID
	
END
GO
/****** Object:  StoredProcedure [dbo].[EliminarUsuario]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[EliminarUsuario] 
	@UsuarioID int

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


delete from Usuarios where UsuarioID=@UsuarioID


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ListaJuegoPremios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListaJuegoPremios] 
	@JuegoID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from JuegoPremios 
                where JuegoID= @JuegoID 
                 and  Activo = 1 ;
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ListarJuego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarJuego] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from juego where Activo=1
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ListarJuegoImagenes]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarJuegoImagenes] 
	-- Add the parameters for the stored procedure here
	@JuegoID int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select a.JuegoID,a.JuegoPremiosID,a.TipoPremioID,a.Secuencia,b.Nombre,
                 b.Imagen,isnull(b.ImagenSlice, replicate(' ', 100)) as ImagenSlice,b.TextoSlice,b.ColorSlice 
                 from JuegoPremios a, TipoPremio b 
                 where  
				 a.JuegoID = @JuegoID and
                 b.TipoPremioID = a.TipoPremioID 
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ListarJuegosActivos]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarJuegosActivos] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Juego where GETDATE()  between FechaDesde and FechaHasta and Activo = 1
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ListarUsuarios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListarUsuarios] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Usuarios where Activo=1
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ListaTipoJuego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListaTipoJuego] 
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from TipoJuego
                where Activo = 1 ;
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ListaTipoPremio]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ListaTipoPremio] 
		-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from TipoPremio
where Activo=1


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[LoginAdmin]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LoginAdmin] 
	@Login varchar(20),
	@Clave varchar(200)
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from Usuarios
	where Login=@Login
	and Clave=@Clave
	and Activo=1

	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerJuego]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerJuego] 
	@JuegoID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from Juego
where JuegoID=@JuegoID and Activo=1


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerJuegoByID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerJuegoByID] 
	@JuegoID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from Juego
where JuegoID=@JuegoID and Activo=1


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerJuegoParticipanteOportunidadesById]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerJuegoParticipanteOportunidadesById] 
	@ID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from JuegoParticipanteOportunidades where JuegoParticipanteOportunidadID= @ID
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerJuegoParticipanteOportunidadesID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerJuegoParticipanteOportunidadesID] 
	@JuegoParticipanteID int,
	@CodigoOportunidad varchar(10)
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select JuegoParticipanteOportunidadID from JuegoParticipanteOportunidades 
                where JuegoParticipantesID =   @JuegoParticipanteID 
                 and CodigoOportunidad = @CodigoOportunidad 
                 and  Activo = 1
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerJuegoParticipantesByID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerJuegoParticipantesByID] 
	@JuegoParticipanteID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from JuegoParticipantes 
                where JuegoParticipantesID = @JuegoParticipanteID 
                 and  Activo = 1

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerJuegoParticipantesID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerJuegoParticipantesID] 
	@JuegoID int,
	@ParticipanteID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select JuegoParticipantesID from JuegoParticipantes 
                where JuegoID = @JuegoID
                 and ParticipanteID = @ParticipanteID 
                 and  Activo = 1;

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerJuegoPremiosByID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerJuegoPremiosByID] 
	@JuegoID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from JuegoPremios
where JuegoPremiosID=@JuegoID and Activo=1


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerParticipanteByI]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerParticipanteByI] 
	@ID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	select * from participante where ParticipanteID=@ID;
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerParticipanteByID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ObtenerParticipanteByID] 
	@ID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	select * from participante where ParticipanteID=@ID;
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerParticipanteID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerParticipanteID] 
	@TipoDocumento varchar(10),
	@NumeroDocumento varchar(10),
	@CodigoContribuyente varchar(10)

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select ParticipanteID from Participante 
                where TipoDocumento = @TipoDocumento
                 and NumeroDocumento = @NumeroDocumento
                 and CodigoContribuyente = @CodigoContribuyente
                and Activo = 1;
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerPremioOtorgarDiaByNumeroParticipante]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerPremioOtorgarDiaByNumeroParticipante] 
	@JuegoID int,
	@NumeroParticipante int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from PremioOtorgarDia 
where JuegoID=@JuegoID and NumeroParticipante = @NumeroParticipante and Activo=1


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerTipoPremioByID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerTipoPremioByID] 
	@TipoPremioID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from TipoPremio
where TipoPremioID=@TipoPremioID and Activo=1


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerUsuarioAdmin]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerUsuarioAdmin] 
	@login varchar(20)

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from Usuarios 
                where Login = @Login
                and Activo = 1;
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[ObtenerUsuarioByID]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ObtenerUsuarioByID] 
	@UsuarioID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from Usuarios
where UsuarioID=@UsuarioID and Activo=1


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[RegistrarJugada]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RegistrarJugada] 
	@JuegoParticipanteOportunidadID int,
	@Ganador bit,
	@TipoPremioID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	if (@Ganador=1) 
		begin
		update JuegoParticipanteOportunidades set Jugado=1,
                Ganador = @Ganador,
                FechaJuego = GETDATE() , 
                FechaGanador =  GETDATE(),
				TipoPremioID = @TipoPremioID
                WHERE JuegoParticipanteOportunidadID=@JuegoParticipanteOportunidadID;
		end
	else
		begin
		update JuegoParticipanteOportunidades set Jugado=1,
                Ganador = @Ganador,
                FechaJuego = GETDATE()  
                WHERE JuegoParticipanteOportunidadID=@JuegoParticipanteOportunidadID;
		end
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[RegistrarJugadaParticipante]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RegistrarJugadaParticipante] 
	@JuegoParticipantesID int,
	@Ganador bit
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	if (@Ganador=1) 
		begin
		update JuegoParticipantes set OpcionesJugadas=OpcionesJugadas+1,
                Ganador = @Ganador,
                FechaGanador =  GETDATE()
                WHERE JuegoParticipantesID=@JuegoParticipantesID;
		end
	else
		begin
		update JuegoParticipantes set OpcionesJugadas=OpcionesJugadas+1
                WHERE JuegoParticipantesID=@JuegoParticipantesID;
		end
	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[RolesPorUsuario]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RolesPorUsuario] 
	@UsuarioID int
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	

    -- Insert statements for procedure here
	 select * from UsuarioRoles
where UsuarioID=@UsuarioID and Activo=1


	

	
                 
	
END
GO
/****** Object:  StoredProcedure [dbo].[TotalizarJuegoPremios]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TotalizarJuegoPremios] 
		@JuegoID int 
	

	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	


update Juego set TotalPremios = ( select sum(cantidad) from JuegoPremios where JuegoID=@JuegoID ),
				TotalPremiosDia = ( select sum(TotalPremiosDia) from JuegoPremios where JuegoID=@JuegoID)
where JuegoID=@JuegoID



	

	
                 
	
END
GO
/****** Object:  Trigger [dbo].[JuegoLogTrigger]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[JuegoLogTrigger] ON [dbo].[Juego] FOR DELETE, INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    --Unpivot deleted
    WITH deleted_unpvt AS (
        SELECT JuegoID, FieldName, FieldValue
        FROM 
           (SELECT JuegoID
                , cast(Nombre as sql_variant) Nombre
                , cast(FechaDesde as sql_variant) FechaDesde
                , cast(FechaHasta as sql_variant) FechaHasta
				, cast(NumeroSegmentos as sql_variant) NumeroSegmentos
				, cast(TotalPremios as sql_variant) TotalPremios
				, cast(TotalPremiosDia as sql_variant) TotalPremiosDia
				, cast(TotalPremiosParticipante as sql_variant) TotalPremiosParticipante
				, cast(ColorImagen as sql_variant) ColorImagen
           FROM deleted) p
        UNPIVOT
           (FieldValue FOR FieldName IN 
              (Nombre, FechaDesde, FechaHasta, NumeroSegmentos, TotalPremios, TotalPremiosDia, TotalPremiosParticipante, ColorImagen)
        ) AS deleted_unpvt
    ),
    --Unpivot inserted
    inserted_unpvt AS (
        SELECT JuegoID, FieldName, FieldValue
        FROM 
           (SELECT JuegoID
                , cast(Nombre as sql_variant) Nombre
                , cast(FechaDesde as sql_variant) FechaDesde
                , cast(FechaHasta as sql_variant) FechaHasta
				, cast(NumeroSegmentos as sql_variant) NumeroSegmentos
				, cast(TotalPremios as sql_variant) TotalPremios
				, cast(TotalPremiosDia as sql_variant) TotalPremiosDia
				, cast(TotalPremiosParticipante as sql_variant) TotalPremiosParticipante
				, cast(ColorImagen as sql_variant) ColorImagen
           FROM inserted) p
        UNPIVOT
           (FieldValue FOR FieldName IN 
              (Nombre, FechaDesde, FechaHasta, NumeroSegmentos, TotalPremios, TotalPremiosDia, TotalPremiosParticipante, ColorImagen)
        ) AS inserted_unpvt
    )

    --Join them together and show what's changed
    INSERT INTO Log_Juego (JuegoID, Campo, ValorAnterior, ValorActual)
    SELECT Coalesce (D.JuegoID, I.JuegoID) JuegoID
        , Coalesce (D.FieldName, I.FieldName) FieldName
        , D.FieldValue as FieldValueWas
        , I.FieldValue AS FieldValueIs 
    FROM 
        deleted_unpvt d

            FULL OUTER JOIN 
        inserted_unpvt i
            on      D.JuegoID = I.JuegoID 
                AND D.FieldName = I.FieldName
    WHERE
         D.FieldValue <> I.FieldValue --Changes
        OR (D.FieldValue IS NOT NULL AND I.FieldValue IS NULL) -- Deletions
        OR (D.FieldValue IS NULL AND I.FieldValue IS NOT NULL) -- Insertions
END
GO
ALTER TABLE [dbo].[Juego] ENABLE TRIGGER [JuegoLogTrigger]
GO
/****** Object:  Trigger [dbo].[TriggerName]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TriggerName] ON [dbo].[Sample_Table] FOR DELETE, INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    --Unpivot deleted
    WITH deleted_unpvt AS (
        SELECT ContactID, FieldName, FieldValue
        FROM 
           (SELECT ContactID
                , cast(Forename as sql_variant) Forename
                , cast(Surname as sql_variant) Surname
                , cast(Extn as sql_variant) Extn
                , cast(Email as sql_variant) Email
                , cast(Age as sql_variant) Age
           FROM deleted) p
        UNPIVOT
           (FieldValue FOR FieldName IN 
              (Forename, Surname, Extn, Email, Age)
        ) AS deleted_unpvt
    ),
    --Unpivot inserted
    inserted_unpvt AS (
        SELECT ContactID, FieldName, FieldValue
        FROM 
           (SELECT ContactID
                , cast(Forename as sql_variant) Forename
                , cast(Surname as sql_variant) Surname
                , cast(Extn as sql_variant) Extn
                , cast(Email as sql_variant) Email
                , cast(Age as sql_variant) Age
           FROM inserted) p
        UNPIVOT
           (FieldValue FOR FieldName IN 
              (Forename, Surname, Extn, Email, Age)
        ) AS inserted_unpvt
    )

    --Join them together and show what's changed
    INSERT INTO Sample_Table_Changes (ContactID, FieldName, FieldValueWas, FieldValueIs)
    SELECT Coalesce (D.ContactID, I.ContactID) ContactID
        , Coalesce (D.FieldName, I.FieldName) FieldName
        , D.FieldValue as FieldValueWas
        , I.FieldValue AS FieldValueIs 
    FROM 
        deleted_unpvt d

            FULL OUTER JOIN 
        inserted_unpvt i
            on      D.ContactID = I.ContactID 
                AND D.FieldName = I.FieldName
    WHERE
         D.FieldValue <> I.FieldValue --Changes
        OR (D.FieldValue IS NOT NULL AND I.FieldValue IS NULL) -- Deletions
        OR (D.FieldValue IS NULL AND I.FieldValue IS NOT NULL) -- Insertions
END
GO
ALTER TABLE [dbo].[Sample_Table] ENABLE TRIGGER [TriggerName]
GO
/****** Object:  Trigger [dbo].[TriggerNamex]    Script Date: 29/5/2018 7:09:04 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TRIGGER [dbo].[TriggerNamex] ON [dbo].[Sample_Table] FOR DELETE, INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON;
    --Unpivot deleted
    WITH deleted_unpvt AS (
        SELECT ContactID, FieldName, FieldValue
        FROM 
           (SELECT ContactID
                , cast(Forename as sql_variant) Forename
                , cast(Surname as sql_variant) Surname
                , cast(Extn as sql_variant) Extn
                , cast(Email as sql_variant) Email
                , cast(Age as sql_variant) Age
           FROM deleted) p
        UNPIVOT
           (FieldValue FOR FieldName IN 
              (Forename, Surname, Extn, Email, Age)
        ) AS deleted_unpvt
    ),
    --Unpivot inserted
    inserted_unpvt AS (
        SELECT ContactID, FieldName, FieldValue
        FROM 
           (SELECT ContactID
                , cast(Forename as sql_variant) Forename
                , cast(Surname as sql_variant) Surname
                , cast(Extn as sql_variant) Extn
                , cast(Email as sql_variant) Email
                , cast(Age as sql_variant) Age
           FROM inserted) p
        UNPIVOT
           (FieldValue FOR FieldName IN 
              (Forename, Surname, Extn, Email, Age)
        ) AS inserted_unpvt
    )

    --Join them together and show what's changed
    INSERT INTO Sample_Table_Changes (ContactID, FieldName, FieldValueWas, FieldValueIs)
    SELECT Coalesce (D.ContactID, I.ContactID) ContactID
        , Coalesce (D.FieldName, I.FieldName) FieldName
        , D.FieldValue as FieldValueWas
        , I.FieldValue AS FieldValueIs 
    FROM 
        deleted_unpvt d

            FULL OUTER JOIN 
        inserted_unpvt i
            on      D.ContactID = I.ContactID 
                AND D.FieldName = I.FieldName
    WHERE
         D.FieldValue <> I.FieldValue --Changes
        OR (D.FieldValue IS NOT NULL AND I.FieldValue IS NULL) -- Deletions
        OR (D.FieldValue IS NULL AND I.FieldValue IS NOT NULL) -- Insertions
END
GO
ALTER TABLE [dbo].[Sample_Table] ENABLE TRIGGER [TriggerNamex]
GO


SET IDENTITY_INSERT [dbo].[TipoJuego] ON
 
INSERT [dbo].[TipoJuego] ([TipoJuegoID], [Nombre], [Activo], [Usuario], [FechaCreacion], [UsuarioUltimaVez], [FechaUltimaVez]) VALUES (1, N'Ruleta', 1, N'sa', CAST(N'2018-05-17T23:06:15.767' AS DateTime), NULL, NULL)

SET IDENTITY_INSERT [dbo].[TipoJuego] OFF
