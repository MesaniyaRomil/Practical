namespace Practical.Models
{
    public class HomeViewClass
    {
        public string numbers { get; set; }
        public bool IsAsc { get; set; }
    }
    public class SortData
    {
        public int Id { get; set; }
        public string? RequestSortNumber { get; set; }
        public string? SortingDirection { get; set; }
        public string? Timetaken { get; set; }
        public string? ResponseSortNumber { get; set; }
        public Nullable<DateTime> DataAdded { get; set; }
        public string? Validation { get; set; }

    }
}
