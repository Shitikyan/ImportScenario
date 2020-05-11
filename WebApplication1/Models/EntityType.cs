using System;
using System.Collections.Generic;
using System.Text;

namespace ImportScenario.Models
{
    public class EntityType
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string TableName { get; set; }
        public EntityTypeEnum Type { get; set; }
    }
}
