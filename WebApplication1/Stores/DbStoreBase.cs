using Microsoft.Extensions.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace ImportScenario.Stores
{
    public class DbStoreBase
    {
        private const string CON_STR_KEY = "ConnectionString";
        private readonly IConfiguration _configuration;
        private readonly string _mainConnectionString;

        protected DbStoreBase(IConfiguration configuration)
        {
            _configuration = configuration;
            _mainConnectionString = _configuration.GetConnectionString(CON_STR_KEY);
        }

        protected IDbConnection CreateConnection()
        {
            return new SqlConnection(_mainConnectionString);
        }
    }
}
