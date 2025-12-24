# Conan 2 Playground mit Artifactory Upload & Lockfiles

Dieses Repo ist ein **modernes Conan‑2 Setup** mit:

- **Eigenen Conan‑Paketen** (Beispiele: `hello/0.1.0`, `adder/0.1.0`)
- **Consumer‑C++‑Projekt** (CMake + Conan 2: `CMakeToolchain` + `CMakeDeps`)
- **Linux & Windows Scripts** (Bash + PowerShell)
- **Lockfiles** für reproduzierbare Graphen
- **Upload/Download via Artifactory** (Token-basiert, CI‑Release Workflow)
- **Optionale lokale Remotes**
  - schnell: `conan_server` (für Tests)
  - empfohlen: Artifactory CE for C/C++ (Docker)

> Hinweis: `conan_server` ist primär für Tests gedacht; für Teams/produktiven Betrieb wird Artifactory empfohlen.

---

## Voraussetzungen

- Python 3.8+ (für Conan 2)
- Conan 2 (`pip install conan`)
- CMake **>= 3.23** (Preset‑Flow)
- Compiler:
  - Linux: GCC/Clang
  - Windows: Visual Studio (MSVC)

---

## Quickstart (ohne eigenen Server)

### Profile erstellen

Linux/macOS:

```bash
./scripts/init_profiles.sh
```

Windows (PowerShell):

```powershell
./scripts/init_profiles.ps1
```

### Pakete lokal bauen

Linux/macOS:

```bash
./scripts/build_all_packages.sh
```

Windows:

```powershell
./scripts/build_all_packages.ps1
```

### Consumer bauen (nutzt lokale Conan-Cache-Binaries)

Linux/macOS:

```bash
./scripts/build_consumer.sh
```

Windows:

```powershell
./scripts/build_consumer.ps1
```

---

## Repo-managed Conan Config (Profiles/Remotes)

Für reproduzierbare Builds empfiehlt Conan, eigene Profile im Repo zu pflegen und per `conan config install` zu verteilen.

Installiere die Repo-Config:

Linux/macOS:

```bash
./scripts/install_conan_config.sh
```

Windows:

```powershell
./scripts/install_conan_config.ps1
```

Das Profil `common`:

- setzt den CMake-Generator auf **Ninja**
- zieht **cmake** und **ninja** als `tool_requires` (Build‑Tools) über Conan

---

## Lockfiles (reproduzierbare Dependency Graphs)

Lockfiles pinnen den Graph (inkl. revisions), damit Builds später reproduzierbar bleiben.

Linux/macOS:

```bash
./scripts/lock_consumer.sh
```

Windows:

```powershell
./scripts/lock_consumer.ps1
```

Anwenden eines Lockfiles:

```powershell
cd apps/consumer
conan install . -of build -s build_type=Release --lockfile=../../locks/consumer_release.lock --build=missing
cmake --preset conan-release
cmake --build --preset conan-release
```

---

## Artifactory Upload (Tokens)

1) `.env.example` nach `.env` kopieren und Variablen setzen (oder direkt in der Shell/CI setzen)
2) Remote hinzufügen + Login
3) Pakete bauen
4) Upload ausführen

Linux/macOS:

```bash
source .env
./scripts/remote_add_artifactory.sh
./scripts/build_all_packages.sh
./scripts/upload_internal.sh artifactory
```

Windows:

```powershell
# env vars setzen (z.B. im Terminal oder CI)
./scripts/remote_add_artifactory.ps1
./scripts/build_all_packages.ps1
./scripts/upload_internal.ps1 -RemoteName artifactory
```

Mehr Details: `docs/artifactory.md`.

---

## Lokale Remote starten (Option A): conan_server (schnell, für Tests)

Linux/macOS:

```bash
./scripts/server_conan_server.sh
./scripts/remote_add_local.sh
./scripts/upload_internal.sh local
```

Windows:

```powershell
./scripts/server_conan_server.ps1
./scripts/remote_add_local.ps1
./scripts/upload_internal.ps1 -RemoteName local
```

Default User/Passwort: `demo/demo` (siehe `tools/conan_server/server.conf`)

---

## Lokale Remote starten (Option B): Artifactory CE for C/C++ (empfohlen)

```bash
docker compose -f tools/artifactory/docker-compose.yml up -d
```

---

## Conan-Pakete in einem CMake-Projekt verwenden (Consumer-Pattern)

Im Consumer (`apps/consumer`):

```bash
cd apps/consumer
conan install . -of build --build=missing -s build_type=Release -pr:b default -pr:b ../../conan-config/profiles/common
cmake --preset conan-release
cmake --build --preset conan-release
```

Wenn du statt Cache aus Artifactory ziehen willst, stelle sicher, dass Artifactory als Remote vorhanden ist und in der Remote-Reihenfolge passend steht (`conan remote list`).
