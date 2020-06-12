#!/usr/bin/env bash.origin.script

if ! BO_has php; then
		echo >&2 "ERROR: 'php' command not found!"
		exit 1
fi

function PRIVATE_ensureTimezoneSet {
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

PRIVATE_ensureTimezoneSet


function EXPORTS_eval {
	php -r "$1"
}

function EXPORTS_run {
	php -S "127.0.0.1:${1}" -t "$(pwd)"
}

function EXPORTS_start {
    # TODO: Terminate if our process terminates
	php -S "127.0.0.1:${1}" -t "$(pwd)" &
}

function EXPORTS_stop {
	ps -ef | grep "127.0.0.1:${1}" | grep -v grep | awk '{print $2}' | xargs kill -9
}

function PRIVATE_ensureComposerInstalled {
	# @see https://github.com/composer/composer/blob/master/CONTRIBUTING.md

	BO_ensureInSystemCache SOURCE_DOWNLOADED_PATH \
			"github.com/composer/composer" \
			"1.9.0" \
			"https://github.com/composer/composer/archive/1.9.0.zip"

	pushd "$SOURCE_DOWNLOADED_PATH" > /dev/null
		if [ ! -e ".installed" ]; then
			BO_ensureInSystemCache PHAR_DOWNLOADED_PATH \
					"getcomposer.org/composer.phar" \
					"1.9.0" \
					"https://getcomposer.org/composer.phar"
			php "$PHAR_DOWNLOADED_PATH" install
			touch ".installed"
		fi
	popd > /dev/null

	BO_setResult "$1" "$SOURCE_DOWNLOADED_PATH"
}

function EXPORTS_composer {
	local COMPOSER_DIR
	PRIVATE_ensureComposerInstalled "COMPOSER_DIR"
	"$COMPOSER_DIR/bin/composer" $@
}
