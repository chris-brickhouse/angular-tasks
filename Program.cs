using Microsoft.AspNetCore.Http.Json;

string MyAllowSpecificOrigins = "_myAllowSpecificOrigins";

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddHttpContextAccessor();
builder.Services.AddSwaggerGen(c => {
    c.SwaggerDoc("v1", new() { Title = "SO", Version = "v1" });
});

var provider = builder.Services.BuildServiceProvider();
var context = provider.GetService<IHttpContextAccessor>();

// builder.Services.AddDbContext<SOModels>(options => options.UseSqlServer(config.GetConnectionString("S1Medical"), opt => { opt.EnableRetryOnFailure(5, TimeSpan.FromSeconds(10), null); }), ServiceLifetime.Transient);
builder.Services.AddCors(options => {
    options.AddPolicy(name: MyAllowSpecificOrigins,
      builder => {
          builder.WithOrigins("http://localhost:4200", "http://localhost");
      });
});

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddControllers();
// Set the JSON serializer options
builder.Services.Configure<JsonOptions>(options => {
    options.SerializerOptions.PropertyNameCaseInsensitive = false;
    options.SerializerOptions.PropertyNamingPolicy = null;
    options.SerializerOptions.WriteIndented = true;
});

await using var app = builder.Build();

if (app.Environment.IsDevelopment()) {
    app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI(c => c.SwaggerEndpoint("/swagger/v1/swagger.json", "S1Medical v1"));
} else {
    // app.UseExceptionHandler(a => a.Run(async context => {
    //   var exceptionHandlerPathFeature = context.Features.Get<IExceptionHandlerPathFeature>();
    //   var ex = exceptionHandlerPathFeature.Error;
    //   ErrorHandler.SaveError(ex);
    //   context.Response.Redirect("/Error");
    // }));
}

app.Use(async (context, next) => {
    //Access-Control-Allow-Origin
    context.Response.Headers.Add("Access-Control-Allow-Origin", "*");
    context.Response.Headers.Add("Access-Control-Allow-Methods", "GET,HEAD,OPTIONS,POST,PUT");
    context.Response.Headers.Add("Cache-Control", "no-cache, no-store");
    context.Response.Headers.Add("Access-Control-Allow-Headers", "Access-Control-Allow-Origin, Origin, X-Requested-With, Content-Type, Accept, Authorization, content-type, Bearer, token, observe, UserID");
    context.Response.Headers.Add("Expires", "-1");
    await next();
});
app.UseCors(MyAllowSpecificOrigins);

string api_url = (app.Environment.IsDevelopment()) ? "/api" : "";

// public calls
app.MapGet(api_url + "/todos", [AllowAnonymous] async (HttpContext context, IWebHostEnvironment env) => { return new TodoService(hca: context, env: env).All; });

await app.RunAsync();
