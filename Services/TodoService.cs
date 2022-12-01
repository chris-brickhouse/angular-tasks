namespace Test.Services;
public class TodoService : BaseService {

    public TodoService(int id = 0, HttpContext hca = null, IWebHostEnvironment env = null) : base(hca: hca, env: env) {
        if (id > 0) {
            Todo = (from e in db.Todos where e.TaskID == id select e).FirstOrDefault() ?? new Todo();
        }
    }

    public virtual Todo Todo { get; set; } = new Todo();
    public virtual List<Todo> All {
        get {
            return (from e in db.Todos select e).ToList();
        }
    }

    public async Task<int> Save(string eo) {
        Todo t = JsonSerializer.Deserialize<Todo>(eo);
        db.Todos.Update(t);
        await db.SaveChangesAsync();
        return t.TaskID;
    }

    public async void Delete(int id) {
        db.Todos.Remove(db.Todos.Find(id));
        await db.SaveChangesAsync();

    }
}

