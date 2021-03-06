USE [Tourcan]
GO
DELETE FROM [dbo].[resp]
GO
DELETE FROM [dbo].[theme]
GO
DELETE FROM [dbo].[tripitem]
GO
DELETE FROM [dbo].[trip]
GO
DELETE FROM [dbo].[photo]
GO
DELETE FROM [dbo].[hotel]
GO
DELETE FROM [dbo].[att]
GO
DELETE FROM [dbo].[quest]
GO
DELETE FROM [dbo].[mem]
GO
DELETE FROM [dbo].[sex]
GO
DELETE FROM [dbo].[region]
GO
DELETE FROM [dbo].[admin]
GO
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (0, N'N/A', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (1, N'臺北市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (2, N'新北市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (3, N'桃園市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (4, N'臺中市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (5, N'臺南市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (6, N'高雄市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (7, N'基隆市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (8, N'新竹市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (9, N'嘉義市', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (10, N'新竹縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (11, N'苗栗縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (12, N'彰化縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (13, N'南投縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (14, N'雲林縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (15, N'嘉義縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (16, N'屏東縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (17, N'宜蘭縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (18, N'花蓮縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (19, N'臺東縣', 0)
INSERT [dbo].[region] ([region_id], [region_name], [region_area]) VALUES (20, N'澎湖縣', 0)
INSERT [dbo].[sex] ([sex], [sex_declare]) VALUES (0, N'N/A')
INSERT [dbo].[sex] ([sex], [sex_declare]) VALUES (1, N'MALE')
INSERT [dbo].[sex] ([sex], [sex_declare]) VALUES (2, N'FEMALE')
INSERT [dbo].[sex] ([sex], [sex_declare]) VALUES (9, N'OTHER')
SET IDENTITY_INSERT [dbo].[mem] ON 

INSERT [dbo].[mem] ([mem_lname], [mem_fname], [mem_nick], [mem_sex], [region_id], [mem_bdate], [mem_account], [mem_pwd], [mem_id], [mem_regtime], [mem_email], [mem_mobile], [mem_photo]) VALUES (N'劉', N'慶和', N'Pingu', 0, 0, CAST(0x02180B00 AS Date), N'pingu8007', N'12345678', 1, CAST(0x9E3B0B00 AS Date), N'pingu8007@gmail.com', NULL, NULL)
SET IDENTITY_INSERT [dbo].[mem] OFF
