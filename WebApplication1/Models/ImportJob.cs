using System;

namespace ImportScenario.Models
{
    public class ImportJob
    {
		public int Id { get; set; }

		public DateTime CreatedOn { get; set; }

		public int CoreEntityId { get; set; }

		public string FileName { get; set; }

		public string ColumnMappings { get; set; }

		public string ScenarioName { get; set; }

		public string Status { get; set; }

		public DateTime ValidatedOn { get; set; }

		public DateTime ImportedOn { get; set; }

		public string OperationStatus { get; set; }

		public string OperationMessage { get; set; }

		public int TotalRows { get; set; }

		public int ValidRows { get; set; }

		public int NewRows { get; set; }

		public int UpdatedRows { get; set; }

		public string GlobalId { get; set; }

		public DateTime RowVersion { get; set; }
    }
}
