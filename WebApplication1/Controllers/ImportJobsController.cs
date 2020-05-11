using ImportScenario.Models;
using ImportScenario.Services;
using ImportScenario.ViewModels;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using System.Linq;
using System.Threading.Tasks;

namespace ImportScenario.Controllers
{
    public class ImportJobsController : Controller
    {
        private readonly ILogger<ImportJobsController> _logger;
        private readonly EntityStore _entityStore;

        public ImportJobsController(ILogger<ImportJobsController> logger, EntityStore entityStore)
        {
            _logger = logger;
            _entityStore = entityStore;
        }

        public IActionResult Index()
        {
            return View(null);
        }
    }
}
