#!/bin/false

# Vivado initialization settings

if {[info exists ::env(GIT_LOCAL_REPOS)]} {
    set git_repos $::env(GIT_LOCAL_REPOS)
} else {
    set git_repos "$::env(HOME)/git-local-repos"
}

set avnet_boards "Avnet/bdf"
set digilent_boards "Digilent/vivado-boards/new/board_files"

# Set the available board repos to use
set avail_repo_paths \
    [list \
        "${git_repos}/${avnet_boards}" \
        "${git_repos}/${digilent_boards}"]
set_param board.repoPaths "${avail_repo_paths}"

# Now dump them out to stdout
set repo_paths [get_param board.repopaths]
if { "${repo_paths}" == "" } {
    puts stdout "WARNING: Board file repo path is empty"
} else {
    puts "Available board repository paths:"
    foreach repo ${repo_paths} {
        puts "  ${repo}"
    }
}

