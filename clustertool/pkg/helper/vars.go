package helper

import (
    "os"
    "path/filepath"
)

var (
    HelmCache       = filepath.Join(CacheDir, "tgz_cache")
    UserCacheDir, _ = os.UserCacheDir()
    TalEnv          = make(map[string]string)
    ClusterName     = "main"
    KubeCache       = filepath.Join(CacheDir, "kubernetes")
    BaseCache       = filepath.Join(CacheDir, "base")
    RootCache       = filepath.Join(CacheDir, "root")
    PatchCache      = filepath.Join(CacheDir, "patches")
    DocsCache       = filepath.Join(CacheDir, "docs")
    CacheDir        = filepath.Join(UserCacheDir, "clustertool")
    ClusterPath     = filepath.Join("./clusters", ClusterName)
    ClusterEnvFile  = filepath.Join(ClusterPath, "/clusterenv.yaml")
    TalConfigFile   = filepath.Join(ClusterPath, "/talos", "talconfig.yaml")
    TalosPath       = filepath.Join(ClusterPath, "/talos")
    KubernetesPath  = filepath.Join(ClusterPath, "/kubernetes")
    TalosGenerated  = filepath.Join(TalosPath, "/generated")
    TalosConfigFile = filepath.Join(TalosGenerated, "talosconfig")
    TalSecretFile   = filepath.Join(TalosGenerated, "talsecret.yaml")
    AllIPs          = []string{}
    ControlPlaneIPs = []string{}
    WorkerIPs       = []string{}

    IndexCache = "./index_cache"
    GpgDir     = ".cr-gpg" // Adjust the path based on your project structure
    Logo       = `
  _______               _____ _                _
 |__   __|             / ____| |              | |
    | |_ __ _   _  ___| |    | |__   __ _ _ __| |_ ___
    | | '__| | | |/ _ \ |    | '_ \ / _` + "`" + ` | '__| __/ __|
    | | |  | |_| |  __/ |____| | | | (_| | |  | |_\__ \
    |_|_|   \__,_|\___|\_____|_| |_|\__,_|_|   \__|___/
          _______         __         ______          __
         / ___/ /_ _____ / /____ ___/_  __/__  ___  / /
        / /__/ / // (_-</ __/ -_) __// / / _ \/ _ \/ /
        \___/_/\_,_/___/\__/\__/_/  /_/  \___/\___/_/

`
)
