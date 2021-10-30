#!/bin/bash
set -e

rm -f /d_rails/tmp/pids/server.pid

exec "$@"