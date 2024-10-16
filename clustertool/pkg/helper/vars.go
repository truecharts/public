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
	CacheDir        = filepath.Join(UserCacheDir, "clustertool")
	ClusterPath     = filepath.Join("./clusters", ClusterName)
	ClusterEnvFile  = filepath.Join(ClusterPath, "/clusterenv.yaml")
	TalConfigFile   = filepath.Join(ClusterPath, "/talos", "talconfig.yaml")
	TalosPath       = filepath.Join(ClusterPath, "/talos")
	TalosGenerated  = filepath.Join(TalosPath, "/generated")
	TalosConfigFile = filepath.Join(TalosGenerated, "talosconfig")
	TalSecretFile   = filepath.Join(TalosGenerated, "talsecret.yaml")
	AllIPs          = []string{}
	ControlPlaneIPs = []string{}
	WorkerIPs       = []string{}
	KubeFilterStr   = []string{
		".*would violate PodSecurity.*",
	}

	IndexCache = "./index_cache"
	GpgDir     = ".cr-gpg" // Adjust the path based on your project structure
)
