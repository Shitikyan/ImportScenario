using Microsoft.Extensions.Configuration;
using Dapper;
using System.Data;
using System.Threading.Tasks;
using ImportScenario.Stores;

namespace ImportScenario.Services
{
    public class LocalizationService : DbStoreBase
    {
        public LocalizationService(IConfiguration config) : base(config)
        {
        }

        public Task<string> GetLocalizedValue(string resourceName)
        {
            return GetLocalizedValue(System.Globalization.CultureInfo.CurrentCulture.TwoLetterISOLanguageName, resourceName);
        }

        public async Task<string> GetLocalizedValue(string twoLetterCode, string resourceName)
        {
            const string qry = @"select lr.ResourceLocalizedName
from sys_LocalizedResources lr
left join sys_languages l on TwoLetterCode = @TwoLetterCode
WHERE lr.LanguageId = l.Id AND ResourceName = @ResourceName";
            using (IDbConnection conn = CreateConnection())
            {
                conn.Open();
                var result = await conn.ExecuteScalarAsync<string>(qry, new
                {
                    TwoLetterCode = twoLetterCode,
                    ResourceName = resourceName
                });
                return result ?? resourceName;
            }
        }

    }
}
