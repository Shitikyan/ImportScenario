using Microsoft.Extensions.Configuration;
using Dapper;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace ImportScenario.Services
{
    public class LocalizationService
    {
        readonly IConfiguration _config;
        public LocalizationService(IConfiguration config)
        {
            _config = config;
        }

        IDbConnection CreateConnection()
        {
            return new SqlConnection(_config.GetConnectionString("ConnectionString"));
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
