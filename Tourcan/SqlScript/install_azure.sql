CREATE TABLE [dbo].[admin](
	[admin_name] [nvarchar](20) NOT NULL,
	[admin_account] [varchar](40) NOT NULL,
	[admin_pwd] [varchar](max) NOT NULL,
	[admin_id] [int] IDENTITY(1,1) NOT NULL,
	[admin_level] [int] NOT NULL,
 CONSTRAINT [PK_admin] PRIMARY KEY CLUSTERED 
(
	[admin_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE [dbo].[att](
	[att_name] [nvarchar](50) NOT NULL,
	[att_id] [int] IDENTITY(1,1) NOT NULL,
	[att_staytime] [int] NOT NULL,
	[region_id] [int] NOT NULL,
	[att_addr] [nvarchar](max) NOT NULL,
	[att_price] [money] NULL,
	[att_phone] [varchar](50) NULL,
	[att_url] [varchar](max) NULL,
	[att_eat] [bit] NOT NULL,
	[att_intro] [nvarchar](max) NULL,
	[att_open] [nvarchar](max) NULL,
	[att_lat] [decimal](8,6) NOT NULL,
	[att_lng] [decimal](9,6) NOT NULL,
 CONSTRAINT [PK_att] PRIMARY KEY CLUSTERED 
(
	[att_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE [dbo].[hotel](
	[hotel_id] [int] IDENTITY(1,1) NOT NULL,
	[region_id] [int] NOT NULL,
	[hotel_name] [nvarchar](20) NOT NULL,
	[hotel_price] [money] NOT NULL,
	[hotel_addr] [nvarchar](max) NOT NULL,
	[hotel_phone] [varchar](50) NULL,
	[hotel_class] [int] NOT NULL,
	[hotel_url] [varchar](max) NULL,
	[hotel_lat] [decimal](8,6) NOT NULL,
	[hotel_lng] [decimal](9,6) NOT NULL,
 CONSTRAINT [PK_hotel] PRIMARY KEY CLUSTERED 
(
	[hotel_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE [dbo].[mem](
	[mem_lname] [nvarchar](20) NOT NULL,
	[mem_fname] [nvarchar](20) NOT NULL,
	[mem_nick] [nvarchar](20) NULL,
	[mem_sex] [int] NOT NULL,
	[region_id] [int] NOT NULL,
	[mem_bdate] [date] NOT NULL,
	/*
	[mem_account] [varchar](40) /*NOT*/ NULL,
	[mem_pwd] [varchar](max) /*NOT*/ NULL,
	[mem_id] [int] /*IDENTITY(1,1) NOT*/ NULL,
	*/
	[mem_regtime] [date] NOT NULL,
	[mem_email] [varchar](50) NOT NULL,
	[mem_mobile] [varchar](50) NULL,
	[mem_photo] [varbinary](max) NULL,
	[mem_uid] [varchar](128) NOT NULL,
 CONSTRAINT [PK_mem] PRIMARY KEY CLUSTERED 
(
	[mem_uid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE [dbo].[photo](
	[photo_id] [int] IDENTITY(1,1) NOT NULL,
	[photo_file] [varbinary](max) NOT NULL,
	[att_id] [int] NULL,
	[hotel_id] [int] NULL,
 CONSTRAINT [PK_photo] PRIMARY KEY CLUSTERED 
(
	[photo_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE [dbo].[quest](
	[quest_catalog] [int] NOT NULL,
	[quest_topic] [nvarchar](20) NOT NULL,
	[quest_id] [int] IDENTITY(1,1) NOT NULL,
	/*[mem_id] [int] NOT NULL,*/
	[mem_uid] [varchar](128) NOT NULL,
	[quest_quiz] [nvarchar](max) NOT NULL,
	[admin_id] [int] NULL,
	[quest_reply] [nvarchar](max) NULL,
	[quest_qtime] [datetime] NOT NULL,
	[quest_rtime] [datetime] NULL,
 CONSTRAINT [PK_quest] PRIMARY KEY CLUSTERED 
(
	[quest_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE [dbo].[region](
	[region_id] [int] NOT NULL,
	[region_name] [nvarchar](8) NOT NULL,
	[region_area] [int] NOT NULL,
 CONSTRAINT [PK_region] PRIMARY KEY CLUSTERED 
(
	[region_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[resp](
	/*[mem_id] [int] NOT NULL,*/
	[mem_uid] [varchar](128) NOT NULL,
	[resp_time] [datetime] NOT NULL,
	[resp_article] [nvarchar](max) NOT NULL,
	[theme_id] [int] NOT NULL,
	[resp_id] [int] IDENTITY(1,1) NOT NULL,
	[resp_topic] [nvarchar](30) NULL,
 CONSTRAINT [PK_resp] PRIMARY KEY CLUSTERED 
(
	[resp_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE [dbo].[sex](
	[sex] [int] NOT NULL,
	[sex_declare] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_sex] PRIMARY KEY CLUSTERED 
(
	[sex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[theme](
	/*[mem_id] [int] NOT NULL,*/
	[mem_uid] [varchar](128) NOT NULL,
	[theme_time] [datetime] NOT NULL,
	[theme_article] [nvarchar](max) NOT NULL,
	[theme_id] [int] IDENTITY(1,1) NOT NULL,
	[theme_topic] [nvarchar](30) NOT NULL,
	[theme_catalog] [int] NOT NULL,
 CONSTRAINT [PK_theme] PRIMARY KEY CLUSTERED 
(
	[theme_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

CREATE TABLE [dbo].[trip](
	[trip_name] [nvarchar](80) NOT NULL,
	[trip_id] [int] IDENTITY(1,1) NOT NULL,
	[trip_ctime] [datetime] NOT NULL,
	[trip_price] [money] NOT NULL,
	/*[mem_id] [int] NOT NULL,*/
	[mem_uid] [varchar](128) NOT NULL,
 CONSTRAINT [PK_trip] PRIMARY KEY CLUSTERED 
(
	[trip_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];

CREATE TABLE [dbo].[tripitem](
	[trip_id] [int] NOT NULL,
	[tripitem_serial] [int] NOT NULL,
	[tripitem_id] [int] IDENTITY(1,1) NOT NULL,
	[att_id] [int] NULL,
	[tripitem_traffic] [varchar](max) NULL,
	[hotel_id] [int] NULL,
	[tripitem_memo] [nvarchar](max) NULL,
	[tripitem_staytime] [int] NOT NULL,
	[tripitem_begin] [datetime] NOT NULL,
	[tripitem_end] [datetime] NOT NULL,
 CONSTRAINT [PK_tripitem] PRIMARY KEY CLUSTERED 
(
	[tripitem_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY];

ALTER TABLE [dbo].[att]  WITH CHECK ADD  CONSTRAINT [FK_att_region] FOREIGN KEY([region_id])
REFERENCES [dbo].[region] ([region_id]);
ALTER TABLE [dbo].[att] CHECK CONSTRAINT [FK_att_region];
ALTER TABLE [dbo].[hotel]  WITH CHECK ADD  CONSTRAINT [FK_hotel_region] FOREIGN KEY([region_id])
REFERENCES [dbo].[region] ([region_id]);
ALTER TABLE [dbo].[hotel] CHECK CONSTRAINT [FK_hotel_region];
ALTER TABLE [dbo].[mem]  WITH CHECK ADD  CONSTRAINT [FK_mem_region] FOREIGN KEY([region_id])
REFERENCES [dbo].[region] ([region_id]);
ALTER TABLE [dbo].[mem] CHECK CONSTRAINT [FK_mem_region];
ALTER TABLE [dbo].[mem]  WITH CHECK ADD  CONSTRAINT [FK_mem_sex] FOREIGN KEY([mem_sex])
REFERENCES [dbo].[sex] ([sex]);
ALTER TABLE [dbo].[mem] CHECK CONSTRAINT [FK_mem_sex];
ALTER TABLE [dbo].[photo]  WITH CHECK ADD  CONSTRAINT [FK_photo_att] FOREIGN KEY([att_id])
REFERENCES [dbo].[att] ([att_id]);
ALTER TABLE [dbo].[photo] CHECK CONSTRAINT [FK_photo_att];
ALTER TABLE [dbo].[photo]  WITH CHECK ADD  CONSTRAINT [FK_photo_hotel] FOREIGN KEY([hotel_id])
REFERENCES [dbo].[hotel] ([hotel_id]);
ALTER TABLE [dbo].[photo] CHECK CONSTRAINT [FK_photo_hotel];
ALTER TABLE [dbo].[quest]  WITH CHECK ADD  CONSTRAINT [FK_quest_admin] FOREIGN KEY([admin_id])
REFERENCES [dbo].[admin] ([admin_id]);
ALTER TABLE [dbo].[quest] CHECK CONSTRAINT [FK_quest_admin];
ALTER TABLE [dbo].[quest]  WITH CHECK ADD  CONSTRAINT [FK_quest_mem] FOREIGN KEY([mem_uid])
REFERENCES [dbo].[mem] ([mem_uid]);
ALTER TABLE [dbo].[quest] CHECK CONSTRAINT [FK_quest_mem];
ALTER TABLE [dbo].[resp]  WITH CHECK ADD  CONSTRAINT [FK_resp_mem] FOREIGN KEY([mem_uid])
REFERENCES [dbo].[mem] ([mem_uid]);
ALTER TABLE [dbo].[resp] CHECK CONSTRAINT [FK_resp_mem];
ALTER TABLE [dbo].[resp]  WITH CHECK ADD  CONSTRAINT [FK_resp_theme] FOREIGN KEY([theme_id])
REFERENCES [dbo].[theme] ([theme_id]);
ALTER TABLE [dbo].[resp] CHECK CONSTRAINT [FK_resp_theme];
ALTER TABLE [dbo].[theme]  WITH CHECK ADD  CONSTRAINT [FK_theme_mem] FOREIGN KEY([mem_uid])
REFERENCES [dbo].[mem] ([mem_uid]);
ALTER TABLE [dbo].[theme] CHECK CONSTRAINT [FK_theme_mem];
ALTER TABLE [dbo].[trip]  WITH CHECK ADD  CONSTRAINT [FK_trip_mem1] FOREIGN KEY([mem_uid])
REFERENCES [dbo].[mem] ([mem_uid]);
ALTER TABLE [dbo].[trip] CHECK CONSTRAINT [FK_trip_mem1];
ALTER TABLE [dbo].[tripitem]  WITH CHECK ADD  CONSTRAINT [FK_tripitem_att] FOREIGN KEY([att_id])
REFERENCES [dbo].[att] ([att_id]);
ALTER TABLE [dbo].[tripitem] CHECK CONSTRAINT [FK_tripitem_att];
ALTER TABLE [dbo].[tripitem]  WITH CHECK ADD  CONSTRAINT [FK_tripitem_hotel] FOREIGN KEY([hotel_id])
REFERENCES [dbo].[hotel] ([hotel_id]);
ALTER TABLE [dbo].[tripitem] CHECK CONSTRAINT [FK_tripitem_hotel];
ALTER TABLE [dbo].[tripitem]  WITH CHECK ADD  CONSTRAINT [FK_tripitem_trip] FOREIGN KEY([trip_id])
REFERENCES [dbo].[trip] ([trip_id]);
ALTER TABLE [dbo].[tripitem] CHECK CONSTRAINT [FK_tripitem_trip];