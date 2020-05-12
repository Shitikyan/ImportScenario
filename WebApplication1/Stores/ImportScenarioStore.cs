using ImportScenario.Services;
using Microsoft.Extensions.Configuration;

namespace ImportScenario.Stores
{
    public class ImportScenarioStore : DbStoreBase
    {
        private readonly LocalizationService _localizationService;

        public ImportScenarioStore(IConfiguration config, LocalizationService localizationService) : base(config)
        {
            _localizationService = localizationService;
        }
    }
}
