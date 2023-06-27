#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="awscli-local"
BASE_TOOL="awslocal"
TOOL_TEST="$BASE_TOOL --version"

fail() {
	printf "asdf-%s: $*\n" "$TOOL_NAME"
	exit 1
}

list_all_versions() {
	local current_script_path plugin_dir v
	current_script_path=${BASH_SOURCE[0]}
	plugin_dir=$(dirname "$(dirname "$current_script_path")")
	v="$plugin_dir/versions.txt"

	set +e
	pip3 install --user awscli-local== 2>"$v"
	set -e
	sed -i'.bak' -e 's/.*from versions: //g' "$v"
	sed -i'.bak' -e 's/)//g' "$v"
	sed -i'.bak' -e 's/,//g' "$v"
	grep -v ERROR "$v" >"$v.new"
	cat "$v.new"
}

download_release() {
	local version dirname filename
	version=$1
	dirname=$(dirname "$2")
	filename=$(basename "$2")

	printf "* Downloading %s release %s...\n" "$TOOL_NAME" "$version"
	ensure_pip3
	pip3 download --dest "$dirname" "$filename==$version" || fail "could not download from pip"
}

ensure() {
	local check=$1
	local msg=$2
	local res

	eval "$check" >/dev/null
	res=$?
	[ "$res" == "0" ] || fail "$msg (${check} == $res)"
}

ensure_pip3() {
	ensure "which pip3" "it appears pip is not available"
}

ensure_wheel() {
	ensure "pip show wheel" "it appears wheel is not available"
}

install_version() {
	local install_type=$1
	local version=$2
	local install_path=$3

	if [ "$install_type" != "version" ]; then
		fail "supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		local tool_cmd
		tool_cmd="$(printf "%s\n" "$TOOL_TEST" | cut -d' ' -f1)"
		chmod +x "$install_path/bin/$BASE_TOOL"

		install_localstack "$install_path"
		unpack_deps "$install_path"

		[ -x "$install_path/bin/$tool_cmd" ] || fail "expected $install_path/$tool_cmd to be executable."

		printf "%s %s installation was successful!\n" "$TOOL_NAME" "$version"
	) || (
		rm -rf "$install_path"
		fail "an error occurred while installing $TOOL_NAME $version."
	)
}

install_localstack() {
	local install_path=$1

	localstack_client_tar_gz=$(find "$install_path" -name "localstack-client*")
	tar zxf "$localstack_client_tar_gz" --strip-components=1 -C "$install_path"

	localstack_client=$(find "$install_path" -name "localstack_client")
	mv "$localstack_client" "$install_path/bin"
}

unpack_deps() {
	local install_path=$1

	ensure_wheel
	unpack_dep "$install_path" boto3 boto3
	unpack_dep "$install_path" botocore botocore
	unpack_dep "$install_path" jmespath jmespath
	unpack_dep "$install_path" python_dateutil dateutil
	unpack_dep "$install_path" s3transfer s3transfer
	unpack_dep "$install_path" six six.py
	unpack_dep "$install_path" urllib3 urllib3
}

unpack_dep() {
	local install_path=$1
	local dep=$2
	local dep_name=$3

	dep_whl=$(find "$install_path" -name "$dep-*")
	wheel unpack "$dep_whl" --dest "$install_path"

	dep=$(find "$install_path" -maxdepth 2 -name "$dep_name")
	mv "$dep" "$install_path/bin"
}
