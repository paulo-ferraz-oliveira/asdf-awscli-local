#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="awscli-local"
TOOL_TEST="awslocal --version"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
	pip3 install awscli-local== 2>&1 | sed 's/.*from versions: //g' | sed 's/)//g' | grep -v ERROR
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	echo "* Downloading $TOOL_NAME release $version..."
	dest=$(dirname filename)
	pip3 download --dest "$dest" "$filename" || fail "Could not download $url"
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
