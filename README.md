bash.origin.php
===============

[![CircleCI](https://circleci.com/gh/bash-origin/bash.origin.php.svg?style=svg)](https://circleci.com/gh/bash-origin/bash.origin.php)

A plugin for [Bash.Origin](https://github.com/bash-origin/bash.origin) to make [PHP](https://php.net) tools available.


Usage
-----

	#!/bin/bash
	# Source https://github.com/cadorn/bash.origin
	. "$HOME/.bash.origin"
	function init {
		eval BO_SELF_BASH_SOURCE="$BO_READ_SELF_BASH_SOURCE"
		BO_deriveSelfDir ___TMP___ "$BO_SELF_BASH_SOURCE"
		local __BO_DIR__="$___TMP___"

		# Example: Create project using composer
		pushd "$__BO_DIR__/demo-app" > /dev/null
			BO_callPlugin "bash.origin.php@0.1.0" composer create-project symfony-cmf/standard-edition . "~1.2"
		popd > /dev/null
	}
	init


API
---

### `composer ...`

Calls [composer](https://getcomposer.org) for current working directory passing along all arguments.

