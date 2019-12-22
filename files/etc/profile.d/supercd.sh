#!/bin/bash


function cd {
    builtin cd $@
    pwd > ~/.cwd
}


if [ -f ~/.cwd ]; then
    cd "$(cat ~/.cwd)"
fi
