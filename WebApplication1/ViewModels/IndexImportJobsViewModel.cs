using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ImportScenario.Models;

namespace ImportScenario.ViewModels
{
    public class IndexImportJobsViewModel
    {
        public IEnumerable<SelectListItem> EntityTypes { get; set; }

        public int EntityTypeId { get; set; }

        public IEnumerable<EntityTypeColumn> Columns { get; set; }
    }
}
