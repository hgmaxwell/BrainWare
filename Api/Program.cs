using Microsoft.Extensions.DependencyInjection;
using System.Data;
using System.Data.SqlClient;
using System.Reflection;
using Api.Abstractions;
using Api.Infrastructure;

var builder = WebApplication.CreateBuilder(args);
var corsAllowAllOrigins = "AllowAllOrigins";
// Add services to the container.
builder.Services.AddControllers();
builder.Services.AddCors(options =>
{
    options.AddPolicy(corsAllowAllOrigins, builder =>
    {
        builder.AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddScoped<IDbConnection>(sp =>
{
    var configuration = sp.GetRequiredService<IConfiguration>();
    var connectionString = configuration.GetConnectionString("DefaultConnection");
    return new SqlConnection(connectionString);
});

builder.Services.AddScoped<IDatabaseAdapter, SqlDbAdapter>();

var types = Assembly.GetExecutingAssembly().GetTypes()
    .Where(t => (t.Name.EndsWith("Service") || t.Name.EndsWith("Repository")) && t.IsClass);

foreach (var type in types)
{
    var interfaceType = Assembly.GetExecutingAssembly().GetTypes()
        .FirstOrDefault(t => t.IsInterface && t.Name == "I" + type.Name);

    if (interfaceType != null)
    {
        builder.Services.AddScoped(interfaceType, type);
    }
}

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
    app.UseCors(corsAllowAllOrigins);
}

// app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
