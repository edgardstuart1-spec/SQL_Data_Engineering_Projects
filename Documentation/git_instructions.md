# 🛠️ Mis Instrucciones de Git - Proyecto #1

Este archivo contiene los comandos y conceptos esenciales de Git aprendidos durante el curso de Luke Barousse.

## 📸 El Concepto de Snapshot (Instantánea)
Un **snapshot** es una captura del estado exacto de nuestro código en un momento específico del tiempo. Nos permite guardar un historial indestructible y "viajar en el tiempo" si algo falla.

## 🚀 Comandos Esenciales de Navegación (Bash)
* `pwd` – Muestra la ruta absoluta exacta de la carpeta actual.
* `ls -la` – Lista todos los archivos, incluyendo los ocultos (como `.bashrc` o `.git`).
* `cd ..` – Sube un nivel hacia la carpeta padre.
* `cd ~` – Viaja directamente a la carpeta personal (Home).

## 🗂️ Flujo de Trabajo en Git

### 1. Ver el estado actual
Para revisar qué archivos han cambiado o están listos para la "foto":
```bash
git status
```

### 2. Preparar los archivos (Staging Area)
Antes de tomar el snapshot, debemos elegir qué archivos incluir:
* Preparar un archivo específico:
  ```bash
  git add documentation/git_instructions.md
  ```
* Preparar absolutamente todo lo que cambió:
  ```bash
  git add .
  ```

### 3. Tomar el Snapshot (Commit)
Guarda la "fotografía" en tu historial local con un mensaje claro:
```bash
git commit -m "feat: agrega guía de instrucciones de Git"
```

### 4. Subir los cambios a la nube (GitHub)
Envía tus snapshots locales a tu repositorio remoto:
```bash
git push origin main
```
