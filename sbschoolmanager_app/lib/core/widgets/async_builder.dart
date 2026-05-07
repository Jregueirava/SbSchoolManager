
import "package:flutter/material.dart";
import "../errors/app_exception.dart";

class AsyncBuilder<T> extends StatelessWidget {
  final Future<T> future;
  final Widget Function(T data) builder;
  final VoidCallback? onRetry;

  const AsyncBuilder({
    super.key,
    required this.future,
    required this.builder,
    this.onRetry
  });

  @override
  Widget build(BuildContext context){
    return FutureBuilder(future: future, builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.hasError){
        return _ErrorView(
        error:snapshot.error!,
        onRetry:onRetry,
        );
      }
      return builder(snapshot.data as T);
    },
    );
  }
}

  class _ErrorView extends StatelessWidget{
    final Object error;
    final VoidCallback? onRetry;

    const _ErrorView({required this.error, this.onRetry});

    //Eleccion de icono y mensaje de error
    (IconData, String) _parsearError(){
      if(error is NetworkException){
        return (Icons.wifi_off, error.toString());
      }
      if(error is NotFoundException){
        return (Icons.search_off, error.toString());
      }
      if(error is ServerException){
        return (Icons.cloud_off, error.toString());
      }
      return (Icons.error_outline, "Ocurrió un error inesperado");
    }

    @override
    Widget build(BuildContext context){
      final (icono, mensaje)= _parsearError();

      return Center(
        child: 
      Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icono, size: 64,
            color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(mensaje,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
            ),
            if(onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton.icon(onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text("Reintentar"),
              ),
            ],
          ],
        ),
        ),
        );
    }
  }