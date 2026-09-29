using Microsoft.EntityFrameworkCore;
using NexPlayAPI.Endpoints;
using NexPlayAPI.Models;
using NexPlayAPI.Services;

var builder = WebApplication.CreateBuilder(args);

// ===============================
// Cadena de conexión
// ===============================

var connectionString = builder.Configuration
    .GetConnectionString("NexPlayConnection")
    ?? throw new InvalidOperationException(
        "No se encontró la cadena de conexión NexPlayConnection."
    );

// ===============================
// Base de datos
// ===============================

builder.Services.AddDbContext<NexPlayContext>(options =>
    options.UseMySql(
        connectionString,
        ServerVersion.AutoDetect(connectionString)
    ));

// ===============================
// Servicios de Paola
// ===============================

builder.Services.AddScoped<UsuarioService>();
builder.Services.AddScoped<AuthService>();
builder.Services.AddScoped<AvatarService>();
builder.Services.AddScoped<JuegoService>();
builder.Services.AddScoped<CategoriaJuegoService>();

// ===============================
// Servicios de Joselin
// ===============================

builder.Services.AddScoped<PartidaService>();
builder.Services.AddScoped<RetoService>();
builder.Services.AddScoped<LogroService>();
builder.Services.AddScoped<RankingService>();

// ===============================
// Swagger
// ===============================

builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// ===============================
// CORS para Flutter
// ===============================

builder.Services.AddCors(options =>
{
    options.AddPolicy("FlutterDev", policy =>
    {
        policy
            .AllowAnyOrigin()
            .AllowAnyMethod()
            .AllowAnyHeader();
    });
});

var app = builder.Build();

// ===============================
// CORS
// IMPORTANTE: antes de StaticFiles
// ===============================

app.UseCors("FlutterDev");

// ===============================
// Archivos estáticos
// Permite acceder a wwwroot
//
// Ejemplo:
// wwwroot/avatars/Gaara_Nexplay.png
//
// URL:
// http://localhost:5290/avatars/Gaara_Nexplay.png
// ===============================

app.UseStaticFiles();

// ===============================
// Swagger
// ===============================

if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// ===============================
// HTTPS
// Desactivado temporalmente para
// desarrollo local con Flutter Web
// ===============================

// app.UseHttpsRedirection();

// ===============================
// Endpoints de Paola
// ===============================

app.MapUsuarioEndpoints();
app.MapAuthEndpoints();
app.MapAvatarEndpoints();
app.MapJuegoEndpoints();
app.MapCategoriaJuegoEndpoints();

// ===============================
// Endpoints de Joselin
// ===============================

app.MapPartidaEndpoints();
app.MapRetoEndpoints();
app.MapLogroEndpoints();
app.MapRankingEndpoints();

// ===============================
// Ejecutar aplicación
// ===============================

app.Run();