#!/bin/bash

export QT_QPA_PLATFORM=xcb
export QT_PLUGIN_PATH=/app/extra/dingtalk/current_version

setup_ime_env() {
    if [[ "$XMODIFIERS" =~ fcitx ]]; then
        [ -z "$QT_IM_MODULE" ] && export QT_IM_MODULE=fcitx
        [ -z "$GTK_IM_MODULE" ] && export GTK_IM_MODULE=fcitx
    elif [[ "$XMODIFIERS" =~ ibus ]]; then
        [ -z "$QT_IM_MODULE" ] && export QT_IM_MODULE=ibus
        [ -z "$GTK_IM_MODULE" ] && export GTK_IM_MODULE=ibus
    fi
}

setup_ime_env

ulimit -c 0

cd /app/extra/dingtalk/current_version || exit 1

env LD_PRELOAD="/app/lib/glibc/lib64/libm.so.6 /app/lib/libstdc/libstdc++.so.6" \
    ./com.alibabainc.dingtalk "$@"
