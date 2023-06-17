#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="awscli-local"
TOOL_TEST="awslocal --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

list_all_versions() {
	current_script_path=${BASH_SOURCE[0]}
	plugin_dir=$(dirname "$(dirname "$current_script_path")")
	v="${plugin_dir}/versions.txt"

	set +e
	pip3 install --user awscli-local== 2>"${v}"
	set -e
	sed -i 's/.*from versions: //g' "$v"
	sed -i 's/)//g' "$v"
	sed -i 's/,//g' "$v"
	grep -v ERROR "$v" | cat | awk -F' ' '{ for (i = 1; i <= NF; i++) print $i }' >"$v.new"
	cat "$v.new"
}

download_release() {
	local version filename
	version="$1"
	filename="$2"

	echo "* Downloading $TOOL_NAME release $version..."
	dest=$(dirname filename)
	pip3 download --dest "$dest" "$filename" || fail "Could not download from pip"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
