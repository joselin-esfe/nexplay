using Microsoft.EntityFrameworkCore;
using NexPlayAPI.Endpoints;
using NexPlayAPI.Models;
using NexPlayAPI.Services;

var builder = WebApplication.CreateBuilder(args);

var connectionString = builder.Configuration
    .GetConnectionString("NexPlayConnection")
    ?? throw new InvalidOperationException("No se encontró la cadena de conexión NexPlayConnection.");

builder.Services.AddDbContext<NexPlayContext>(options =>
    options.UseMySql(
        connectionString,
        ServerVersion.AutoDetect(connectionString)
    ));

builder.Services.AddScoped<PartidaService>();
builder.Services.AddScoped<RetoService>();
builder.Services.AddOpenApi();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
}

app.UseHttpsRedirection();

app.MapPartidaEndpoints();
app.MapRetoEndpoints();

app.Run();