# 🛠️ MANUAL COMPLETO DE GIT Y GITHUB: DE CERO A PROFESIONAL

¡Bienvenido a tu manual definitivo! Git no es más que una **máquina del tiempo** para tu código. Este documento está diseñado para que entiendas qué hace cada comando en el mundo real, con peras y manzanas, sin tecnicismos raros.

---

## 🛠️ 1. Conceptos Básicos (Para entender el juego)

Antes de tocar el teclado, debes entender los 4 estados en los que vive tu código:

1. **Working Directory (Carpeta Local):** Tu carpeta normal en la computadora donde estás editando con VS Code. Git ve los cambios (en rojo), pero aún no los guarda.
2. **Staging Area (La Sala de Espera):** Aquí pones los archivos que quieres incluir en tu siguiente "fotografía" (en verde). Estás preparando la maleta para el viaje.
3. **Local Repository (Historial Seguro):** El baúl de los recuerdos en tu computadora donde se guardan tus fotografías cerradas e indestructibles (**Commits**).
4. **Remote Repository (GitHub en la Nube):** La copia exacta de tu baúl, pero guardada en internet para que sirva de portafolio y no se pierda si tu laptop explota.

---

## 📌 2. El Kilómetro Cero (Instalación y Verificación)

### ¿Cómo saber si Git está instalado?
Abre tu terminal de VS Code y escribe:
```bash
git --version
```
* **Si te devuelve `git version 2.x.x`:** Ya estás listo.
* **Si te devuelve un error:** No está en tu sistema.

### El secreto de Git Bash (Para Windows)
La forma estándar para programar en Windows es descargar **Git for Windows** desde `https://git-scm.com`. 
* **¿Qué es Git Bash?:** Durante la instalación, te regalarán esta terminal especial. Imita el comportamiento de los sistemas Linux/Mac dentro de Windows. Es exactamente la misma terminal que integras dentro de VS Code para ejecutar tus comandos.

---

## 📌 3. Tu Identidad Digital (Configuración por única vez)

Git necesita saber quién tomó cada fotografía del código. Ejecuta esto una sola vez en tu computadora:

```bash
# Configura tu nombre real
git config --global user.name "Edgar Stuart"

# Configura tu correo de GitHub
git config --global user.email "tu_correo_gmail@gmail.com"
```

---

## 📌 4. El Mundo Web (Tu cuenta en GitHub.com)

1. Entra a `https://github.com` y regístrate con tu correo de **Gmail**.
2. Elige un usuario profesional (como `edgardstuart1-spec`). Su enlace será tu carta de presentación ante reclutadores.
3. **Crear un Repositorio:** Haz clic en el botón verde **New** (Nuevo). Ponle un nombre (ej. `SQL_Data_Engineering_Projects`) y déjalo **Público**. Nadie podrá modificar tu código sin tu permiso, pero todos podrán ver tu talento.

---

## 📌 5. El Trabajo Local (Rastreo, Auditoría y Guardado)

Para activar la máquina del tiempo en una carpeta nueva desde cero, usas:
```bash
git init
```

### El Escáner (`git status`)
Te dice en qué estado están tus archivos:
```bash
git status
```
* 🔴 **Rojo:** Modificados en tu Carpeta Local.
* 🟢 **Verde:** En la Sala de Espera, listos para la foto.

### La Lupa Científica (`git diff`)
Antes de guardar, audita tu código. Te muestra las líneas exactas que cambiaste en tus scripts de SQL:
```bash
git diff
```
* Muestra lo viejo que borraste en **rojo** (`-`) y lo nuevo que escribiste en **verde** (`+`).

### Preparar la Maleta (`git add`)
* **`git add mi_script.sql`**: Envía un archivo específico a la sala de espera verde.
* **`git add .`**: (Lleva un espacio antes del punto). Mete **absolutamente todos** los archivos modificados a la sala de espera de un solo golpe.

### Tomar la Instantánea (`git commit`)
Cierra la maleta y congela ese momento en el tiempo para siempre:
```bash
git commit -m "feat: agrega analisis de salarios top 10"
```

### El Historial de Viaje (`git log`)
Para revisar todas las fotos que has tomado en el pasado:
```bash
git log --oneline
```
* Te muestra una lista compacta de tus capturas pasadas con sus mensajes.

---

## 📌 6. Las Ramas (Líneas de tiempo alternativas)

Por defecto, tu proyecto vive en la línea de tiempo principal llamada `main`. Las ramas (**branches**) sirven para experimentar sin romper lo que ya funciona.

### Ver tus ramas actuales
```bash
git branch
```
* Te mostrará una lista de las ramas y un asterisco `*` en la que estás parado actualmente.

### Crear una rama nueva
Imagínate que quieres probar un query SQL muy loco pero no quieres arruinar tu archivo principal. Creas una rama llamada `experimento`:
```bash
git branch experimento
```

### Viajar entre líneas de tiempo (`git checkout` o `git switch`)
Para moverte a la rama que acabas de crear y empezar a trabajar ahí de forma segura:
```bash
git checkout experimento
```
*(Nota: Todo lo que guardes con `git commit` dentro de esta rama se quedará atrapado en esta línea de tiempo y no afectará a la rama `main`).*

### El atajo de oro (Crear y viajar de un solo golpe)
Para no escribir dos comandos, puedes usar la bandera `-b` para crear la rama y saltar a ella de inmediato:
```bash
git checkout -b nueva-rama-sql
```

### Fusionar los cambios (`git merge`)
Si tu experimento con el query SQL fue un éxito total y quieres integrarlo a tu proyecto principal:
1. Regresas a la rama principal: `git checkout main`
2. Absorbes los cambios de la rama experimental:
```bash
git merge experimento
```

---

## 📌 7. La Trilogía de la Nube (Conectando con GitHub)

### El primer empujón (`git push -u origin main`)
La **primerísima vez** que conectas tu VS Code con tu repositorio de GitHub, usas el comando largo de Luke:
```bash
git push -u origin main
```
* **Credenciales:** Se abrirá una pestaña en Chrome. Das clic en "Autorizar" y tu computadora recordará tu cuenta para siempre. Si tu consola es antigua y te pide contraseña, debes generar un **PAT (Personal Access Token)** en la configuración de desarrollador de GitHub, ya que las contraseñas normales ya no se permiten por seguridad.

### 💡 La Regla del Éxito del Día a Día
Una vez que ya ejecutaste ese primer comando largo, el puente quedó construido para siempre. De aquí en adelante, para subir tus nuevas fotos a la nube, **ya solo usas el comando corto a secas:**
```bash
git push
```

### Traer datos y el secreto de `git pull`
Cuando necesitas traer cambios de internet, `git pull` actúa como un atajo inteligente que ejecuta dos acciones en un segundo:

* **Paso A (`git fetch`):** Va a GitHub, inspecciona si hay novedades y las descarga de forma oculta **sin tocar tu código actual**. Es 100% seguro para revisar qué hay de nuevo.
* **Paso B (`git merge`):** Fusiona y une esas novedades de internet con tus archivos locales en la pantalla.
* **El Atajo (`git pull`):** En lugar de escribir ambos, escribes `git pull` y Git hace el `fetch` y el `merge` al mismo tiempo.