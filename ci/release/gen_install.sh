#!/bin/sh
set -eu
cd -- "$(dirname "$0")/../.."
. ./ci/sub/lib.sh

cat >./install.sh <<EOF
#!/bin/sh
set -eu

# *************
# DO NOT EDIT
#
# install.sh was bundled together from
#
# - ./ci/sub/lib/rand.sh
# - ./ci/sub/lib/log.sh
# - ./ci/sub/lib/flag.sh
# - ./ci/sub/lib/release.sh
# - ./ci/release/_install.sh
#
# The last of which implements the installation logic.
#
# Generated by ./ci/release/gen_install.sh.
# *************

EOF

# sed removes the sourcing dependency lines as we're bundled everything into a single
# script.
sh_c cat \
  ./ci/sub/lib/rand.sh \
  ./ci/sub/lib/log.sh \
  ./ci/sub/lib/flag.sh \
  ./ci/sub/lib/release.sh \
  \| sed "-e'/^\. /d'" \>\> ./install.sh
sh_c cat ./ci/release/_install.sh \
  \| sed -n "'/cd -- \"\$(dirname/,/cd -/!p'" \>\> install.sh