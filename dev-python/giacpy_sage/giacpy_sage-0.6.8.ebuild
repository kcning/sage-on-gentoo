# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit distutils-r1

DESCRIPTION="A Cython frontend to the c++ library giac for sage"
HOMEPAGE="https://www.imj-prg.fr/~frederic.han/xcas/giacpy"
SRC_URI="http://webusers.imj-prg.fr/~frederic.han/xcas/giacpy/sage/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=sci-mathematics/giac-1.5.0.43
	>=sci-mathematics/sage-8.9[${PYTHON_USEDEP}]
	>=dev-python/cython-0.24[${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.6.7-nolibdir.patch
	)