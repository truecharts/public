git config --global advice.detachedHead false;

for plugin in $(env | grep "TC_PLUGIN_REPO_");
do
  # Get the variable name
  plugin_name=$(echo "${plugin}" | cut -d '=' -f1);
  plugin_name=${plugin_name#"TC_PLUGIN_REPO_"}
  # Get the plugin repo from the variable
  plugin_repo=$(echo "${plugin}" | cut -d '=' -f2);
  # Get the version from the VERSION Prefixed variable
  version=$(env | grep "TC_PLUGIN_VERSION_$plugin_name" | cut -d '=' -f2);
  echo "${plugin_name}: Cloning ${plugin_repo} at ${version} into /plugins-local/src/${plugin_repo}";
  # Clone the single "branch" (tag) into the plugins-local folder
  git clone "https://${plugin_repo}" "/plugins-local/src/${plugin_repo}" \
    --depth 1 --branch "${version}" --single-branch;
done

echo "Plugins cloned into /plugins-local/src:"

ls -lah /plugins-local/src
