USE [CRM25_CUSTOMER]
GO
INSERT [dbo].[sys_npm_property] ([Resource], [HideCLI], [StatusID], [CoolDownPeriod], [CoolDownDurDate], [LockedBy], [LockedDate], [TariffCode], [ChangeStatusDate], [CreateUserID], [CreateDate], [UpdateUserID], [UpdateDate], [DataStatus], [NUMBERTYPEID], [locationid]) VALUES (N'34B73335911', 0, 9, NULL, NULL, NULL, NULL, NULL, CAST(0x0000A2CE00989298 AS DateTime), NULL, NULL, 1000000022, CAST(0x0000A2CE00989298 AS DateTime), NULL, NULL, NULL)

INSERT [dbo].[sys_npm_dealer] ([ID], [Resource], [DealerID], [ShareType]) VALUES (1668080136, N'34B73335911', 503414, 0)

INSERT [dbo].[sys_npm] ([Resource], [TrafficTypeID], [CategoryID], [UpdateUserID], [UpdateDate], [CreateUserID], [CreateDate], [DataStatus]) VALUES (N'34B73335911', 1, 4, 1000000022, CAST(0x0000A2CE00988DE8 AS DateTime), NULL, CAST(0x0000A2CE00988DE8 AS DateTime), NULL)
