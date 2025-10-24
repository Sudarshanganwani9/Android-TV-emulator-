#!/usr/bin/env bash
# env.sh - customize for your environment before running scripts
export ANDROID_SDK_ROOT="${ANDROID_SDK_ROOT:-$HOME/Android/Sdk}"
export HOST_IP="${HOST_IP:-192.168.1.10}"   # change to your machine LAN IP visible to emulator
export AVD_NAME="${AVD_NAME:-Android_TV_1080p_API_30}"
export MITM_PORT="${MITM_PORT:-8080}"
echo "Environment variables set: ANDROID_SDK_ROOT=$ANDROID_SDK_ROOT, HOST_IP=$HOST_IP, AVD_NAME=$AVD_NAME, MITM_PORT=$MITM_PORT"
