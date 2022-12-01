namespace Test.Models;
public class TestModels : DbContext {

    public static string Root { get; set; }
    public static bool IsProd { get; set; }

    public TestModels(string _root = "", bool _isProd = false) {
        Root = _root;
        IsProd = _isProd;
    }

    public virtual DbSet<Todo> Todos { get; set; }

    public TestModels(DbContextOptions<TestModels> options) : base(options) { }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) {
        optionsBuilder.UseSqlServer(GetConnectionString());
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder) {
        base.OnModelCreating(modelBuilder);
    }

    public static string GetConnectionString() {
        string applicationExeDirectory = Root;

        var builder = new ConfigurationBuilder()
        .SetBasePath(applicationExeDirectory)
        .AddJsonFile("appsettings.json");

        var appSettingsJson = builder.Build();
        return appSettingsJson["ConnectionStrings:Test"];
    }

    public static IConfigurationRoot GetAppSettings() {
        string applicationExeDirectory = Root;

        var builder = new ConfigurationBuilder()
        .SetBasePath(applicationExeDirectory)
        .AddJsonFile("appsettings.json")
        .AddJsonFile($"appsettings.{(IsProd ? "Release" : "Development")}.json", optional: true);
        return builder.Build();
    }
}
