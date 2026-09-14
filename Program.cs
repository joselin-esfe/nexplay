using Microsoft.EntityFrameworkCore;
using NexPlayAPI.Models;
using NexPlayAPI.Endpoints;
using NexPlayAPI.Services;

var builder = WebApplication.CreateBuilder(args);

var connectionString = builder.Configuration
    .GetConnectionString("NexPlayConnection")
    ?? throw new InvalidOperationException(
        "No se encontró la cadena de conexión NexPlayConnection."
    );

builder.Services.AddDbContext<NexPlayContext>(options =>
    options.UseMySql(
        connectionString,
        ServerVersion.AutoDetect(connectionString)
    ));

// Servicios de NEXPLAY
builder.Services.AddScoped<UsuarioService>();
builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<AvatarService>();

// Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Swagger solo durante desarrollo
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Endpoints de NEXPLAY
app.MapUsuarioEndpoints();
app.MapAuthEndpoints();
app.MapAvatarEndpoints();

app.Run();