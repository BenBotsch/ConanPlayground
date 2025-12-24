# Artifactory + Conan 2

## Remote-URL

Beim Verbinden mit Artifactory muss die URL den Prefix `/api/conan` enthalten:

```bash
<ARTIFACTORY_URL>/api/conan/<REPO_KEY>
```

Beispiel:

```bash
https://my.jfrog.io/artifactory/api/conan/conan-local
```

## Remote hinzufügen & Login

Setze die Env-Variablen (siehe `.env.example`) und führe aus:

Linux/macOS:

```bash
./scripts/remote_add_artifactory.sh
```

Windows:

```powershell
./scripts/remote_add_artifactory.ps1
```

## Upload

Binaries müssen vorher im lokalen Cache existieren (z.B. durch `conan create`):

```bash
./scripts/build_all_packages.sh
./scripts/upload_internal.sh artifactory
```

## Download/Use

Für Consumers reicht dann `conan install` (Artifactory muss als Remote in der Liste sein).
