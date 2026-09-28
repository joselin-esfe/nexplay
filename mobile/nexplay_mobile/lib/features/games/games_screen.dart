import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../models/game_model.dart';
import '../../models/category_model.dart';
import '../../services/api_service.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  late Future<List<GameModel>> _juegosFuture;
  late Future<List<CategoryModel>> _categoriasFuture;
  int? _selectedCategoriaId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _juegosFuture = ApiService.getJuegos();
    _categoriasFuture = ApiService.getCategorias();
  }

  void _filterByCategory(int? categoriaId) {
    setState(() {
      _selectedCategoriaId = categoriaId;
      if (categoriaId == null) {
        _juegosFuture = ApiService.getJuegos();
      } else {
        _juegosFuture = ApiService.getJuegosPorCategoria(categoriaId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Juegos'),
        backgroundColor: AppColors.surface,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 60,
            child: FutureBuilder<List<CategoryModel>>(
              future: _categoriasFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: SizedBox.shrink());
                }
                if (snapshot.hasError || !snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                final categorias = snapshot.data!;
                return ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ChoiceChip(
                        label: const Text('Todos'),
                        selected: _selectedCategoriaId == null,
                        selectedColor: AppColors.primary,
                        backgroundColor: AppColors.surfaceCard,
                        labelStyle: TextStyle(
                          color: _selectedCategoriaId == null
                              ? AppColors.textWhite
                              : AppColors.textGray,
                        ),
                        onSelected: (selected) {
                          if (selected) _filterByCategory(null);
                        },
                      ),
                    ),
                    ...categorias.map((cat) {
                      final isSelected = _selectedCategoriaId == cat.id;
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(cat.nombre),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          backgroundColor: AppColors.surfaceCard,
                          labelStyle: TextStyle(
                            color: isSelected ? AppColors.textWhite : AppColors.textGray,
                          ),
                          onSelected: (selected) {
                            if (selected) _filterByCategory(cat.id);
                          },
                        ),
                      );
                    }),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<List<GameModel>>(
              future: _juegosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, size: 48, color: AppColors.primary),
                          const SizedBox(height: 16),
                          Text(
                            'Error al cargar juegos:\n${snapshot.error}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: AppColors.textGray),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () => _filterByCategory(_selectedCategoriaId),
                            child: const Text('Reintentar'),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay juegos disponibles',
                      style: TextStyle(color: AppColors.textGray),
                    ),
                  );
                }

                final juegos = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: juegos.length,
                  itemBuilder: (context, index) {
                    final juego = juegos[index];
                    return Card(
                      color: AppColors.surfaceCard,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.border),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: juego.imagenUrl != null && juego.imagenUrl!.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        juego.imagenUrl!,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.sports_esports, color: AppColors.primary),
                                      ),
                                    )
                                  : const Icon(Icons.sports_esports, color: AppColors.primary, size: 40),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    juego.nombre,
                                    style: const TextStyle(
                                      color: AppColors.textWhite,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    juego.descripcion,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: AppColors.textGray,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(alpha: 0.2),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          juego.dificultad,
                                          style: const TextStyle(
                                            color: AppColors.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                          minimumSize: Size.zero,
                                        ),
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text('Iniciando ${juego.nombre}...')),
                                          );
                                        },
                                        child: const Text('Jugar', style: TextStyle(fontSize: 14)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
