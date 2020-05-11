using Dapper;
using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using ImportScenario.Models;

namespace ImportScenario.Services
{
    public class EntityStore
    {
        readonly IConfiguration _config;
        readonly LocalizationService _localizationService;
        public EntityStore(IConfiguration config, LocalizationService localizationService)
        {
            _config = config;
            _localizationService = localizationService;
        }

        public async Task<IEnumerable<EntityType>> GetEntityTypes()
        {
            const string qry = @"select e.Id,e.EntityType as Type,e.TableName,ISNULL(el.Name,e.Name) AS Name from omc_CoreEntities e
left join sys_languages l on TwoLetterCode = @TwoLetterCode
left join omc_CoreEntityLocalizations el on
el.languageId = l.Id AND el.CoreEntityId = e.Id
where EntityType in (3, 1, 4, 5)";
            using (IDbConnection conn = CreateConnection())
            {
                conn.Open();
                var result = await conn.QueryAsync<EntityType>(qry, new { TwoLetterCode = System.Globalization.CultureInfo.CurrentCulture.TwoLetterISOLanguageName });
                return result;
            }
        }

        public async Task<IEnumerable<EntityTypeColumn>> GetEntityTypeColumns(int entityTypeId)
        {
            const string qryEntity = @"select e.Id,e.EntityType As Type,e.TableName,ISNULL(el.Name,e.Name) AS Name from omc_CoreEntities e
left join sys_languages l on TwoLetterCode = @TwoLetterCode
left join omc_CoreEntityLocalizations el on
el.languageId = l.Id AND el.CoreEntityId = e.Id
where e.Id=@EntityTypeId";

            const string qryColumns = @"select ec.Id,e.EntityType AS Type,e.TableName,ISNULL(ecl.Name,ec.Name) AS Name,ec.ColumnName from omc_CoreEntityColumns ec
inner join omc_CoreEntities e on ec.CoreEntityId = e.Id
left join sys_languages l on TwoLetterCode = @TwoLetterCode
left join omc_CoreEntityColumnLocalizations ecl on ecl.languageId = l.Id AND ecl.CoreEntityColumnId = ec.Id
where e.Id=@EntityTypeId";

            const string qryExtensionColumns = @"select ec.Id,e.EntityType AS Type,e.TableName,ISNULL(ecl.Name,ec.Name) AS Name,ec.ColumnName from omc_CoreEntityColumns ec
inner join omc_CoreEntities e on ec.CoreEntityId = e.Id
left join sys_languages l on TwoLetterCode = @TwoLetterCode
left join omc_CoreEntityColumnLocalizations ecl on ecl.languageId = l.Id AND ecl.CoreEntityColumnId = ec.Id
where e.entitytype=2";

            IEnumerable<EntityTypeColumn> result;

            using (IDbConnection conn = CreateConnection())
            {
                conn.Open();

                var entityType = await conn.QuerySingleOrDefaultAsync<EntityType>(qryEntity, new
                {
                    TwoLetterCode = System.Globalization.CultureInfo.CurrentCulture.TwoLetterISOLanguageName,
                    EntityTypeId = entityTypeId
                });

                if (entityType == null)
                    return null;


                if (entityType.Type == EntityTypeEnum.Contact)
                {
                    result = await conn.QueryAsync<EntityTypeColumn>(qryColumns, new
                    {
                        TwoLetterCode = System.Globalization.CultureInfo.CurrentCulture.TwoLetterISOLanguageName,
                        EntityTypeId = entityTypeId
                    });
                    var excludeColumns = new[] { "TimeZoneId", "LanguageId", "CountryId", "CurrencyId" };
                    result = result.Where(x => !excludeColumns.Contains(x.ColumnName));

                    result = result.Concat(new[] {
                        new EntityTypeColumn(){ TableName="omc_Contacts", ColumnName="TimeZone", Name = await (_localizationService.GetLocalizedValue("TimeZone")) },
                        new EntityTypeColumn(){ TableName="omc_Contacts",ColumnName="Language", Name = await (_localizationService.GetLocalizedValue("Language")) },
                        new EntityTypeColumn(){ TableName="omc_Contacts",ColumnName="Country", Name = await (_localizationService.GetLocalizedValue("Country")) },
                        new EntityTypeColumn(){ TableName="omc_Contacts",ColumnName="Currency", Name = await (_localizationService.GetLocalizedValue("Currency")) },
                    });

                    for (int i = 0; i < 3; i++)
                    {
                        var columnName = $"Email {i + 1}";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactEmails", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                    }

                    for (int i = 0; i < 3; i++)
                    {
                        var columnName = $"Mobile {i + 1}";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactMobiles", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                    }

                    for (int i = 0; i < 3; i++)
                    {
                        var columnName = $"Telephone {i + 1}";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactTelephones", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                    }

                    for (int i = 0; i < 3; i++)
                    {
                        var columnName = $"Postal Address {i + 1} Description";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        columnName = $"Postal Address {i + 1} Line 1";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        columnName = $"Postal Address {i + 1} Line 2";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        columnName = $"Postal Address {i + 1} Zip Code";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        columnName = $"Postal Address {i + 1} City";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        columnName = $"Postal Address {i + 1} Country";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        columnName = $"Postal Address {i + 1} PoBox";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        columnName = $"Postal Address {i + 1} Lat";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        columnName = $"Postal Address {i + 1} Lng";
                        result = result.Append(new EntityTypeColumn() { TableName = "omc_ContactPostalAddresses", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                    }

                    result = result.Concat(await conn.QueryAsync<EntityTypeColumn>(qryExtensionColumns, new
                    {
                        TwoLetterCode = System.Globalization.CultureInfo.CurrentCulture.TwoLetterISOLanguageName,
                        EntityTypeId = entityTypeId
                    }));

                    var subscriptionSchemes = await conn.QueryAsync<SubscriptionScheme>("SELECT Code FROM omc_SubscriptionSchemes", new
                    {
                        TwoLetterCode = System.Globalization.CultureInfo.CurrentCulture.TwoLetterISOLanguageName,
                        EntityTypeId = entityTypeId
                    });
                    var channelTypes = await conn.QueryAsync<ChannelType>("SELECT ChannelType as Type, Name FROM omc_ChannelTypesEnumerations", new
                    {
                        TwoLetterCode = System.Globalization.CultureInfo.CurrentCulture.TwoLetterISOLanguageName,
                        EntityTypeId = entityTypeId
                    });

                    foreach (var subscriptionScheme in subscriptionSchemes)
                    {
                        foreach (var channelType in channelTypes)
                        {
                            var columnName = $"{subscriptionScheme.Code}_{channelType.Name}_OptInOut";
                            result = result.Append(new EntityTypeColumn() { TableName = "omc_SubscriptionSchemeExplicitOptInOuts", ColumnName = columnName, Name = await (_localizationService.GetLocalizedValue(columnName)) });
                        }
                    }
                }
                else
                {
                    result = await conn.QueryAsync<EntityTypeColumn>(qryColumns, new
                    {
                        TwoLetterCode = System.Globalization.CultureInfo.CurrentCulture.TwoLetterISOLanguageName,
                        EntityTypeId = entityTypeId
                    });
                }
                return result;
            }
        }


        private IDbConnection CreateConnection()
        {
            return new SqlConnection(_config.GetConnectionString("ConnectionString"));
        }
    }
}
