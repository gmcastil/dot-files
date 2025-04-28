SHELL		:= /bin/bash

UNAME		:= $(shell uname -s)

# If set to 1, an embedded system will be targetd, which creates a subset of
# configuration settings.
EMBEDDED	?= 0

ifeq ($(UNAME),Linux)
	PLATFORM := linux
else ifeq ($(UNAME),Darwin)
	PLATFORM := macos
else
	PLATFORM := unknown
endif

BASH_FILES	:= aliases bashrc bash_profile profile
OTHER_FILES	:= git-prompt prompt less_termcap inputrc dircolors

.PHONY:	shell other clean platform-setup linux-setup macos-setup unknown-setup

setup: shell other platform-setup

shell:
	@for bash_file in $(BASH_FILES); do \
		ln -sfv "$(PWD)/bash/$${bash_file}" "$(HOME)/.$${bash_file}"; \
	done

other:
	@for other_file in $(OTHER_FILES); do \
		ln -sfv "$(PWD)/other/$${other_file}" "$(HOME)/.$${other_file}"; \
	done

platform-setup: $(PLATFORM)-setup

unknown-setup:

macos-setup:
	@printf '%s\n' "Mac OS specific setup" && \
	ln -sfv "$(PWD)/macos/sleep" "$(HOME)/.sleep" && \
	ln -sfv "$(PWD)/macos/wakeup" "$(HOME)/.wakeup"
	@chmod ug+x "$(HOME)/.sleep" "$(HOME)/.wakeup"

linux-setup:
ifneq ($(EMBEDDED),1)
	@mkdir -pv "$(HOME)/.Xilinx/Vivado" && \
	ln -sfv "$(PWD)/Xilinx/Vivado_init.tcl" "$(HOME)/.Xilinx/Vivado/Vivado_init.tcl"
endif

clean:
	@for bash_file in $(BASH_FILES); do \
		if [[ -L "$(HOME)/.$${bash_file}" ]]; then \
			rm -fv "$(HOME)/.$${bash_file}"; \
		elif [[ -f "$(HOME)/.$${bash_file}" ]]; then \
			printf '%s\n' "Skipping file $(HOME)/.$${bash_file}"; \
		fi; \
	done
	@for other_file in $(OTHER_FILES); do \
		if [[ -L "$(HOME)/.$${other_file}" ]]; then \
			rm -fv "$(HOME)/.$${other_file}"; \
		elif [[ -f "$(HOME)/.$${other_file}" ]]; then \
			printf '%s\n' "Skipping file $(HOME)/.$${other_file}"; \
		fi; \
	done
	@if [[ -L "$(HOME)/.Xilinx/Vivado/Vivado_init.tcl" ]]; then \
		rm -fv "$(HOME)/.Xilinx/Vivado/Vivado_init.tcl"; \
	fi
	@if [[ -L "$(HOME)/.sleep" ]]; then \
		rm -rf "$(HOME)/.sleep"; \
	fi
	@if [[ -L "$(HOME)/.wakeup" ]]; then \
		rm -rf "$(HOME)/.wakeup"; \
	fi

test:
	echo $(PLATFORM)
