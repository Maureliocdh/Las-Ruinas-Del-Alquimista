# Las Ruinas del Alquimista

<div align="center">

![Godot Engine](https://img.shields.io/badge/Godot-4.6-blue?style=flat-square&logo=godotengine)
![License](https://img.shields.io/badge/License-MIT-green?style=flat-square)
![Platform](https://img.shields.io/badge/Platform-PC%20%7C%20)

**Un emocionante juego de aventura en 3D combinando plataformas, acción y puzzle**

[Características](#características-principales) • [Instalación](#instalación) • [Controles](#controles) • [Estructura](#estructura-del-proyecto)

</div>

---

## 📋 Descripción

**Las Ruinas del Alquimista** es un juego de aventura 3D desarrollado con Godot Engine, donde los jugadores deben navegar a través de un laberinto oscuro lleno de peligros, enemigos diversos y acertijos. Equipado con power-ups especiales y habilidades dinámicas, deberás escapar de las ruinas ancestrales del poderoso alquimista.

### Trama
Atrapado en un antiguo templo abandonado, debes encontrar la salida mientras evitas enemigos hostiles, esquivas trampas mortales y recolectas artefactos valiosos. ¿Lograrás escapar de las Ruinas del Alquimista?

---

## ⭐ Características Principales

- **Jugabilidad Dinámica**: Plataformas 3D desafiantes con mecánicas de salto y movimiento fluido
- **Sistema de Enemigos Variados**:
  - 🐺 Perseguidores (Chasers) - Te rastrean constantemente
  - 💣 Explotadores (Exploders) - Detonan causando explosiones
  - ⚡ Saltadores (Jumpers) - Atacan saltando
  - 🎯 Torretas (Turrets) - Disparan proyectiles a distancia

- **Power-ups Especiales**:
  - ⚡ **Velocidad**: Aumenta tu velocidad de movimiento
  - 🚀 **Salto Mejorado**: Salta más alto y más lejos
  - 💪 **Poder**: Ataca a enemigos con mayor fuerza

- **Sistema de Progresión**:
  - Recolecta monedas para aumentar tu puntuación
  - Historial de partidas guardado automáticamente
  - Sincronización en la nube con Supabase

- **Interfaz Intuitiva**:
  - Menú principal elegante
  - Menú de pausa con opciones ajustables
  - Pantalla de game over con estadísticas
  - Pantalla de carga cinematográfica

- **Audio Inmersivo**: Sistema de audio dinámico que responde a la acción del juego

---

## 🎮 Requisitos

### Mínimos
- **Motor**: Godot Engine 4.6+
- **SO**: Windows, Linux, macOS
- **RAM**: 2 GB
- **Almacenamiento**: 500 MB

### Recomendados
- **GPU**: Dedicada (NVIDIA/AMD/Intel)
- **RAM**: 4 GB+
- **Pantalla**: 1920x1080 o superior

---

## 🚀 Instalación

### 1. Prerequisitos
```bash
# Descarga Godot 4.6 desde:
https://godotengine.org/download
```

### 2. Clonar el Repositorio
```bash
git clone https://github.com/tu-usuario/Las-Ruinas-Del-Alquimista.git
cd Las-Ruinas-Del-Alquimista/Laberinto-Perdido-main
```

### 3. Abrir Proyecto en Godot
1. Abre el Project Manager de Godot
2. Haz clic en "Importar"
3. Selecciona la carpeta del proyecto
4. Haz clic en "Aceptar"

### 4. Configurar Supabase (Opcional)
Si deseas usar sincronización en la nube:

1. Crea una cuenta en [Supabase](https://supabase.com)
2. Crea un nuevo proyecto
3. Obtén tu URL y clave pública (anon key)
4. Modifica `SupabaseManager.gd` con tus credenciales:
```gdscript
const SUPABASE_URL = "tu_url_aqui"
const SUPABASE_KEY = "tu_clave_aqui"
```

### 5. Ejecutar el Juego
- Presiona <kbd>F5</kbd> o haz clic en el botón "Play" (▶)

---

## 🎮 Controles

| Acción | Tecla/Botón |
|--------|-------------|
| Mover Adelante | <kbd>W</kbd> o <kbd>↑</kbd> |
| Mover Atrás | <kbd>S</kbd> o <kbd>↓</kbd> |
| Mover Izquierda | <kbd>A</kbd> o <kbd>←</kbd> |
| Mover Derecha | <kbd>D</kbd> o <kbd>→</kbd> |
| Saltar | <kbd>Espacio</kbd> |
| Atacar | <kbd>Clic Izquierdo</kbd> |
| Pausa | <kbd>ESC</kbd> |
| Menú | <kbd>ESC</kbd> |

### Controles Móviles
- Joystick virtual para movimiento
- Botones en pantalla para saltar y atacar
- Acelerómetro para cámara (opcional)

---

## 📂 Estructura del Proyecto

```
Laberinto-Perdido-main/
├── 🎬 Escenas Principales
│   ├── game.tscn                    # Escena principal del juego
│   ├── MainMenu.tscn                # Menú principal
│   ├── OptionsMenu.tscn             # Menú de opciones
│   ├── pause_menu.tscn              # Menú de pausa
│   ├── GameOver.tscn                # Pantalla de game over
│   ├── VictoryMenu.tscn             # Pantalla de victoria
│   └── loading_screen.tscn          # Pantalla de carga
│
├── 👤 Jugador y Mecánicas
│   ├── salto.gd                     # Sistema de salto
│   ├── poder.gd                     # Power-up de poder
│   ├── velocidad.gd                 # Power-up de velocidad
│   ├── camera_3d.gd                 # Controlador de cámara
│   └── HUD.gd                       # Interfaz del juego
│
├── 👾 Enemigos
│   ├── EnemyBase.gd                 # Clase base de enemigos
│   ├── enemy_chaser.gd              # Perseguidor
│   ├── enemy_exploder.gd            # Explotador
│   ├── enemy_jumper.gd              # Saltador
│   ├── enemy_turret.gd              # Torreta
│   ├── Enemy.tscn                   # Escena base enemigo
│   ├── EnemyChaser.tscn             # Escena perseguidor
│   ├── EnemyExploder.tscn           # Escena explotador
│   ├── EnemyJumper.tscn             # Escena saltador
│   └── EnemyTurret.tscn             # Escena torreta
│
├── 🎯 Objetos Interactuables
│   ├── coin.gd                      # Script de monedas
│   ├── coin.tscn                    # Escena de moneda
│   ├── bullet.gd                    # Script de proyectiles
│   ├── bullet.tscn                  # Escena de proyectil
│   ├── falling_platform.gd          # Plataformas que caen
│   └── FallingPlatform.tscn         # Escena plataforma que cae
│
├── 🎵 Gestión de Audio
│   ├── AudioManager.gd              # Controlador de audio
│   ├── AudioManager.tscn            # Escena de audio
│   └── *.wav                        # Archivos de sonido
│
├── 💾 Gestión de Datos
│   ├── SaveManager.gd               # Sistema de guardado local
│   ├── SupabaseManager.gd           # Sincronización con Supabase
│   ├── ExcelDataManager.gd          # Gestor de datos Excel
│   ├── HistorialPartidas.gd         # Historial de partidas
│   ├── HistorialPartidosSupabase.gd # Historial en nube
│   └── VerifySupabaseConnection.gd  # Verificación de conexión
│
├── 🎨 Recursos
│   ├── dungeon_environment.tres      # Configuración visual del dungeon
│   ├── default_bus_layout.tres       # Configuración de audio
│   ├── *.jpeg, *.png                 # Imágenes y texturas
│   └── *.import                      # Archivos importados
│
├── ⚙️ Configuración
│   ├── project.godot                 # Configuración del proyecto
│   ├── autoload/                     # Scripts autoload globales
│   └── registrar_partida.py          # Script para registrar partidas
│
└── 📄 Documentación
    ├── README.md                     # Este archivo
    ├── License.txt                   # Licencia del proyecto
    └── reporte_partida.json          # Reporte de ejemplo

```

---

## 🛠️ Tecnologías Utilizadas

- **Motor de Juego**: [Godot Engine 4.6](https://godotengine.org/)
- **Lenguaje**: GDScript (Python-like)
- **Backend**: [Supabase](https://supabase.com) (PostgreSQL + Auth)
- **Audio**: Godot AudioServer
- **Gráficos**: Godot 3D Rendering Engine
- **Version Control**: Git

---

## 📊 Características Técnicas

### Sistemas Implementados

#### 1. **Sistema de Guardado Dual**
- Local: Guardado en archivos JSON locales
- Nube: Sincronización con Supabase

#### 2. **Sistema de Enemigos Inteligente**
- Cada tipo de enemigo tiene comportamiento único
- IA basada en persecución, distancia y patrones
- Colisiones y detección de rango

#### 3. **Física 3D Realista**
- Gravedad realista
- Colisiones precisas
- Raycast para detección de proyectiles

#### 4. **Gestión de Estado Global**
- Autoload de AudioManager
- Autoload de SaveManager
- Autoload de SupabaseManager
- Sistema de eventos centralizado

#### 5. **UI Responsiva**
- Adaptable a diferentes resoluciones
- Menús navegables con teclado/ratón
- Soporte para controles táctiles

---

## 🎯 Cómo Empezar a Jugar

1. **Inicio**: Comienza en el menú principal
2. **Selecciona Dificultad**: Elige entre niveles disponibles
3. **Navega el Laberinto**: 
   - Muévete con WASD
   - Salta con Espacio
   - Recoge power-ups en el camino
4. **Derrota Enemigos**: Usa tu poder para eliminarlos
5. **Recolecta Monedas**: Aumenta tu puntuación
6. **Escapa**: Encuentra la salida para ganar

---

## 🐛 Solución de Problemas

### El juego no inicia
- Verifica que tienes Godot 4.6 instalado
- Recarga el proyecto: Proyecto → Recargar Proyecto Actual

### Los enemigos no aparecen
- Verifica que las escenas de enemigos están instanciadas en `game.tscn`
- Revisa la consola de errores: Vista → Salida → Consola

### Audio no funciona
- Comprueba que los archivos .wav están importados correctamente
- Verifica los niveles de volumen en Menú → Opciones

### Supabase no conecta
- Verifica tu conexión a Internet
- Valida que las credenciales en `SupabaseManager.gd` son correctas
- Comprueba el estado de Supabase en su dashboard

---

## 📈 Desarrollo Futuro

Características planeadas:
- [ ] Más niveles y mapas
- [ ] Nuevos tipos de enemigos
- [ ] Sistema de inventario
- [ ] Jefe final desafiante
- [ ] Multijugador cooperativo
- [ ] Logros y desafíos
- [ ] Mod support (Modding API)
- [ ] Traducción a múltiples idiomas

---

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Para cambios significativos:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/MiFeature`)
3. Commit tus cambios (`git commit -m 'Añade MiFeature'`)
4. Push a la rama (`git push origin feature/MiFeature`)
5. Abre un Pull Request

Por favor, asegúrate de:
- Probar el código antes de enviar PR
- Comentar el código cuando sea necesario
- Seguir el estilo de código existente

---

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver [License.txt](License.txt) para más detalles.

```
MIT License

Copyright (c) 2024 Las Ruinas del Alquimista Contributors

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software...
```

---

## 👥 Créditos

- **Desarrollador Principal**: Omar Said Aguilar Garcia
                               Jose Andres Tovar Esparza
                               Marco Aurelio Alejandro Cortes Diaz Hernandez 
- **Arte y Diseño**: [IA]
- **Audio**: Recursos de audio bajo licencia
- **Motor**: Godot Engine Community

### Recursos Utilizados
- Sonidos: Freesound.org, Pixabay
- Modelos 3D: Godot Asset Store
- Inspiración en clásicos: Portal, Doom, Minecraft

---

## 📞 Contacto y Soporte

- **Email**: marco.cortesdiaz559@alumnos.udg.mx


---

## 🎓 Recursos de Aprendizaje

Útil para quienes quieran aprender del código:

- [Documentación de Godot 4.6](https://docs.godotengine.org/en/stable/index.html)
- [GDScript Manual](https://docs.godotengine.org/en/stable/getting_started/scripting/gdscript/index.html)
- [3D en Godot](https://docs.godotengine.org/en/stable/tutorials/3d/index.html)
- [Tutorial de Supabase con Godot](https://supabase.com/docs)

---

<div align="center">

**¿Disfrutaste del juego? ⭐ Dale una estrella en GitHub!**

Hecho con ❤️ usando Godot Engine

[Arriba ⬆️](#las-ruinas-del-alquimista)

</div>

