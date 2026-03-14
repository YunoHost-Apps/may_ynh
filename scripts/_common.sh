#!/bin/bash

#=================================================
# COMMON VARIABLES AND CUSTOM HELPERS
#=================================================

myynh_install() {
	# Patch source
	ynh_replace --match="0.0.0.0" --replace="127.0.0.1" --file="$install_dir/run.py"
	ynh_replace --match="5050" --replace="$port" --file="$install_dir/run.py"

	# Install with npm
	pushd $install_dir
		ynh_hide_warnings python3 -m venv venv
		ynh_hide_warnings venv/bin/pip3 install -r requirements.txt
	popd

	# Create needed directories
	mkdir -p "/var/log/$app"
	mkdir -p "$data_dir/uploads"
}

# Set permissions
myynh_set_permissions () {
	chown -R $app: "$install_dir"
	chmod u=rwx,g=rx,o= "$install_dir"
	chmod -R o-rwx "$install_dir"

	chown -R $app: "$data_dir"
	chmod u=rwx,g=rx,o= "$data_dir"
	chmod -R o-rwx "$data_dir"

	chown -R $app: "/var/log/$app"
	chmod u=rwx,g=rx,o= "/var/log/$app"
	chmod -R o-rwx "/var/log/$app"
}
