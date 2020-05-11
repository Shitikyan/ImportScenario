using Microsoft.Extensions.Configuration;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;

namespace ImportScenario.Services
{
    public class DbServiceBase
    {
        private const string CON_STR_KEY = "ConnectionString";
        private readonly IConfiguration _configuration;
        private readonly string _mainConnectionString;

        protected DbServiceBase(IConfiguration configuration)
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
