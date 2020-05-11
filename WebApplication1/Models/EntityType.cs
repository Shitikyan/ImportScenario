using System;
using System.Collections.Generic;
using System.Text;

namespace ImportScenario.Models
{
    public class EntityType
    {
        public string Name { get; set; }
        public string TableName { get; set; }
        public int Id { get; set; }
        public EntityTypeEnum Type { get; set; }
    }
}
