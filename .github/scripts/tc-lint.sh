#!/bin/bash

function check_version() {
    chart_path=${1:?"No chart path provided to [Version Check]"}
    target_branch=${2:?"No target branch provided to [Version Check]"}

    new=$(git diff "$target_branch" -- "$chart_path" | sed -nr 's/^\+version: (.*)$/\1/p')
    old=$(git diff "$target_branch" -- "$chart_path" | sed -nr 's/^\-version: (.*)$/\1/p')

    if [[ -z "$new" ]]; then
        echo -e "\t❌ Chart version: Not changed"
        curr_result=1
    fi

    if [[ -n "$new" ]]; then
        echo -e "\t🔙 Old Chart Version: $old"
        echo -e "\t🆕 New Chart Version: $new"

        if [[ $(echo "$new\n$old" | sort -V -r | head -n1) != "$old" ]]; then
            echo -e "\t✅ Chart version: Bumped"
        else
            echo -e "\t❌ Chart version: Not bumped or downgraded"
            curr_result=1
        fi
    fi
}
export -f check_version

function check_chart_schema(){
    chart_path=${1:?"No chart path provided to [Chart.yaml lint]"}

    yamale_output=$(yamale --schema .github/chart_schema.yaml "$chart_path/Chart.yaml")
    yamale_exit_code=$?
    while IFS= read -r line; do
        echo -e "\t$line"
    done <<< "$yamale_output"

    if [ $yamale_exit_code -ne 0 ]; then
        echo -e "\t❌ Chart Schema: Failed"
        curr_result=1
    else
        echo -e "\t✅ Chart Schema: Passed"
    fi
}
export -f check_chart_schema

function helm_lint(){
    chart_path=${1:?"No chart path provided to [Helm lint]"}

    # Print only errors and warnings
    helm_lint_output=$(helm lint --quiet "$chart_path")
    helm_lint_exit_code=$?
    while IFS= read -r line; do
        echo -e "\t$line"
    done <<< "$helm_lint_output"

    if [ $helm_lint_exit_code -ne 0 ]; then
        echo -e "\t❌ Helm Lint: Failed"
        curr_result=1
    else
        echo -e "\t✅ Helm Lint: Passed"
    fi
}
export -f helm_lint

function yaml_lint(){
    file_path=${1:?"No file path provided to [YAML lint]"}

    yaml_lint_output=$(yamllint --config-file .github/yaml-lint-conf.yaml "$file_path")
    yaml_lint_exit_code=$?
    while IFS= read -r line; do
        echo -e "\t$line"
    done <<< "$yaml_lint_output"

    if [ $yaml_lint_exit_code -ne 0 ]; then
        echo -e "\t❌ YAML Lint: Failed [$file_path]"
        curr_result=1
    else
        echo -e "\t✅ YAML Lint: Passed [$file_path]"
    fi
}
export -f yaml_lint

function lint_chart(){
    chart_path=${1:?"No chart path provided to [Lint Chart]"}
    target_branch=${2:?"No target branch provided to [Lint Chart]"}
    status_file=${3:?"No status file provided to [Lint Chart]"}

    curr_result_file=/tmp/$(basename "$chart_path")
    curr_result=0
    {
        start_time=$(date +%s)
        echo '---------------------------------------------------------------------------------------'
        echo "## 🔍Linting [$chart_path]"
        echo '----------------------------------------------'
        echo ''
        echo "👣 Helm Lint - [$chart_path]"
        helm_lint "$chart_path"

        echo "👣 Chart Version - [$chart_path] against [$target_branch]"
        check_version "$chart_path" "$target_branch"

        echo "👣 Chart Schema - [$chart_path]"
        check_chart_schema "$chart_path"

        echo "👣 YAML Lint - [$chart_path/Chart.yaml]"
        yaml_lint "$chart_path/Chart.yaml"

        echo "👣 YAML Lint - [$chart_path/values.yaml]"
        yaml_lint "$chart_path/values.yaml"

        for values in $chart_path/ci/*values.yaml; do
            if [ -f "${values}" ]; then
                echo "👣 YAML Lint - [$values]"
                yaml_lint "$values"
            fi
        done

        end_time=$(date +%s)
        diff_time=$((end_time - start_time))

        echo -e "\nResult:"
        if [ $curr_result -ne 0 ]; then
            echo "❌ Linting [$chart_path]: Failed - Took $diff_time seconds" | tee -a "$result_file"
        else
            echo "✅ Linting [$chart_path]: Passed - Took $diff_time seconds" | tee -a "$result_file"
        fi
        echo '---------------------------------------------------------------------------------------'
        echo ''
    } > "$curr_result_file"
    cat "$curr_result_file"
    echo $curr_result >> "$status_file"
}
export -f lint_chart

# Start of script

charts=$1
target_branch=${2:-"origin/master"}
status_file="/tmp/status"
exit_code=0

result_file=${result_file:?"No result file provided"}

rm -f "$status_file"
rm -f "$status_file"

command -v yamale >/dev/null 2>&1 || {
    printf >&2 "%s\n" "yamale (https://github.com/23andMe/Yamale#pip) is not installed. Aborting."
    printf >&2 "%s\n" "Install it with 'pip install yamale'"
    exit 1
}

command -v yamllint >/dev/null 2>&1 || {
    printf >&2 "%s\n" "yamllint (https://yamllint.readthedocs.io/en/stable/quickstart.html#installing-yamllint) is not installed. Aborting."
    printf >&2 "%s\n" "Install it with 'pip install yamllint'"
    exit 1
}

command -v helm >/dev/null 2>&1 || {
    printf >&2 "%s\n" "helm (https://helm.sh/docs/intro/install) is not installed. Aborting."
    printf >&2 "%s\n" "Install it with 'curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash'"
    exit 1
}

command -v parallel >/dev/null 2>&1 || {
    printf >&2 "%s\n" "parallel (https://www.gnu.org/software/parallel) is not installed. Aborting."
    printf >&2 "%s\n" "Install it with 'sudo apt install parallel'"
    exit 1
}

changed=$(echo $charts | jq --raw-output '.[]')

echo "📂 Charts to lint:"
for chart in $changed; do
    echo -e "\t- 📄 $chart"
done
echo ''

start_time=$(date +%s)
# Run lint_chart in parallel
parallel --jobs $(($(nproc) * 2)) "lint_chart {} $target_branch $status_file" ::: $changed || true
if grep -q 1 "$status_file"; then
    exit_code=1
fi
end_time=$(date +%s)
diff_time=$((end_time - start_time))

echo '------------------------------------'

# Print summary
sorted=$(cat "$result_file" | sort)
sorted=$(echo "$sorted" | sed 's/✅/:heavy_check_mark:/g')
sorted=$(echo "$sorted" | sed 's/❌/:heavy_multiplication_x:/g')
echo "# 📝 Linting results:" | tee "$result_file"
echo '====================================================================================='
echo "$sorted" | tee -a "$result_file"
echo ''
echo -e "Total Charts Linted: **$(echo "$sorted" | wc -l)**" | tee -a "$result_file"
echo -e "Total Charts Passed: **$(echo "$sorted" | grep -c 'heavy_check_mark')**" | tee -a "$result_file"
echo -e "Total Charts Failed: **$(echo "$sorted" | grep -c 'heavy_multiplication_x')**" | tee -a "$result_file"
echo '====================================================================================='
echo '' | tee -a "$result_file"

if [ $exit_code -ne 0 ]; then
    echo "❌ Linting: **Failed** - Took $diff_time seconds" | tee -a "$result_file"
    echo "🖱️ Open [Lint Charts and Verify Dependencies] job" | tee -a "$result_file"
    echo "👀 Expand [Run Chart Linting] step to view the results" | tee -a "$result_file"
else
    echo "✅ Linting: **Passed** - Took $diff_time seconds" | tee -a "$result_file"
fi

exit $exit_code
