# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: gap-pkg.eclass
# @MAINTAINER:
# François Bissey <frp.bissey@gmail.com>
# @SUPPORTED_EAPIS: 7 8
# @BLURB: help standardize the installation of gap package from gap 4.12.0 and over

case ${EAPI} in
	7|8) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

# @FUNCTION: gap-pkg_path
# @USAGE:
# @DESCRIPTION:
# Return the path into which the gap package should be installed.
# The legacy location is usr/share/gap/pkg and the accepted current location is
# usr/$(get_libdir)/gap/pkg

gap-pkg_path() {
	local lower_case_pn=`echo "${PN}" | tr '[:upper:]' '[:lower:]'`
	echo "usr/$(get_libdir)/gap/pkg/${lower_case_pn}"
}

# @VARIABLE: GAP_PKG_OBJS
# @REQUIRED
# @DESCRIPTION:
# List directories to be installed (recursively) and list of other objects to be installed apart from .g objects in S.

# @FUNCTION: gap-pkg_src_install
# @USAGE:
# @DESCRIPTION:
# Create the package directory and install all .g file in ${S} and all objects in GAP_PKGS_OBJS

gap-pkg_src_install() {
	insinto $(gap-pkg_path)

	doins *.g
	for obj in ${GAP_PKG_OBJS}; do
		if [ -d ${obj} ]; then
			doins -r ${obj}
		else
			doins ${obj}
		fi
	done
}

