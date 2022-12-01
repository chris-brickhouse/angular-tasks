namespace Test.Models;

[Table("Todo")]
public class Todo {

    [Key]
    public int TaskID { get; set; }
    public string Name { get; set; }
    public string Desc { get; set; }
    public bool? IsComplete { get; set; }
    public DateTime? TimeStamp { get; set; } = DateTime.Now;
    public bool? DeleteFlag { get; set; } = false;

}
