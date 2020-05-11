using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using ImportScenario.Models;
using ImportScenario.Services;
using ImportScenario.ViewModels;

namespace ImportScenario.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly EntityStore _entityStore;

        public HomeController(ILogger<HomeController> logger, EntityStore entityStore)
        {
            _logger = logger;
            _entityStore = entityStore;
        }

        public async Task<IActionResult> Index()
        {
            var model = new IndexHomeViewModel()
            {
                EntityTypes = (await _entityStore.GetEntityTypes()).Select(c => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem { Text = c.Name, Value = c.Id.ToString() }),
                Columns = Enumerable.Empty<EntityTypeColumn>()

            };
            return View(model);
        }

        [HttpPost]
        public async Task<IActionResult> Index(IndexHomeViewModel model)
        {
            model.EntityTypes = (await _entityStore.GetEntityTypes()).Select(c => new Microsoft.AspNetCore.Mvc.Rendering.SelectListItem() { Text = c.Name, Value = c.Id.ToString() });

            if (model.EntityTypeId > 0)
            {
                model.EntityTypes.Where(c => c.Value == model.EntityTypeId.ToString()).Single().Selected = true;
                model.Columns = await _entityStore.GetEntityTypeColumns(model.EntityTypeId);
            }
            else
            {
                model.Columns = Enumerable.Empty<EntityTypeColumn>();
            }
            return View(model);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
