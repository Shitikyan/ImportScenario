using Microsoft.Extensions.Configuration;
using ImportScenario.Stores;

namespace ImportScenario.Services
{
    public class ImportDataService : DbStoreBase
    {
        private readonly LocalizationService _localizationService;

        public ImportDataService(IConfiguration config, LocalizationService localizationService) : base(config)
        {
            _localizationService = localizationService;
        }
    }
}
