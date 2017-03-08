#!/bin/bash
# Source https://github.com/cadorn/bash.origin
. "$HOME/.bash.origin"
function init {
	eval BO_SELF_BASH_SOURCE="$BO_READ_SELF_BASH_SOURCE"
	BO_deriveSelfDir ___TMP___ "$BO_SELF_BASH_SOURCE"
	local __BO_DIR__="$___TMP___"


	if ! BO_has "php"; then
			# TODO: Install PHP
			echo "ERROR: 'php' command not found. Please install PHP first."
			return
	fi


	function ensureTimezoneSet {
			# TODO: Adapt this to other platforms.
			if [ ! -e "/Library/Server/Web/Config/php" ]; then
					echo "Asking for 'sudo' to create: /Library/Server/Web/Config/php"
					sudo mkdir -p "/Library/Server/Web/Config/php"
					sudo chown $USER "/Library/Server/Web/Config/php"
			fi
			if [ ! -e "/Library/Server/Web/Config/php/.user.ini" ]; then
					touch "/Library/Server/Web/Config/php/.user.ini"
			fi
			if ! grep -qe "^\/.deps$" "/Library/Server/Web/Config/php/.user.ini"; then
			    echo -e "\ndate.timezone = \"America/Vancouver\"" >> "/Library/Server/Web/Config/php/.user.ini"
			fi
	}

	function ensureComposerInstalled {
			# @see https://github.com/composer/composer/blob/master/CONTRIBUTING.md

			BO_ensureInSystemCache SOURCE_DOWNLOADED_PATH \
					"github.com/composer/composer" \
					"1.0.0-alpha10" \
					"https://github.com/composer/composer/archive/1.0.0-alpha10.zip"

			pushd "$SOURCE_DOWNLOADED_PATH" > /dev/null
					if [ ! -e ".installed" ]; then
							BO_ensureInSystemCache PHAR_DOWNLOADED_PATH \
									"getcomposer.org/composer.phar" \
									"1.0.0-alpha10" \
									"https://getcomposer.org/composer.phar"
							php "$PHAR_DOWNLOADED_PATH" install
							touch ".installed"
					fi
			popd > /dev/null

			BO_setResult "$1" "$SOURCE_DOWNLOADED_PATH"
	}

	function composer {
			local COMPOSER_DIR
			ensureComposerInstalled "COMPOSER_DIR"
			"$COMPOSER_DIR/bin/composer" $@
	}

	ensureTimezoneSet

}
init $@
