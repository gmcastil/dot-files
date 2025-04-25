SHELL		:= /bin/bash

SHELL_FILES	:= aliases bashrc bash_profile profile
OTHER_FILES	:= git-prompt prompt dircolors

clean:
	@# Get rid of symlinks to to shell configuration files
	@for shell_file in $(SHELL_FILES); do \
		if [[ -L "$${HOME}/.$${shell_file}" ]]; then \
			rm -f "$${HOME}/.$${shell_file}"; \
		elif [[ -f "$${HOME}/.$${shell_file}" ]]; then \
			printf '%s\n' "Skipping file $${HOME}/.$${shell_file}"; \
		fi \
	done
	@# Get rid of symlinks to other configuration files
	@for other_file in $(OTHER_FILES); do \
		if [[ -L "$${HOME}/.$${other_file}" ]]; then \
			rm -f "$${HOME}/.$${other_file}"; \
		elif [[ -f "$${HOME}/.$${other_file}" ]]; then \
			printf '%s\n' "Skipping file $${HOME}/.$${other_file}"; \
		fi \
	done
