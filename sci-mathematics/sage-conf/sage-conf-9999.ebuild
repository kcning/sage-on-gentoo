# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{9..11} )
PYTHON_REQ_USE="readline,sqlite"
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1 prefix

if [[ ${PV} == 9999 ]]; then
	inherit git-r3 sage-git
	EGIT_REPO_URI="https://github.com/sagemath/sage.git"
else
	inherit pypi
	PYPI_NO_NORMALIZE=1
	KEYWORDS="~amd64 ~amd64-linux ~ppc-macos ~x64-macos"
fi

DESCRIPTION="Math software for abstract and numerical computations"
HOMEPAGE="https://www.sagemath.org"

LICENSE="GPL-2"
SLOT="0"

# No real tests here in spite of QA warnings.
RESTRICT="test mirror"

# pplpy needs to be installed to get documentation folder right :(
DEPEND="~dev-python/pplpy-0.8.7:=[doc,${PYTHON_USEDEP}]"
RDEPEND=""

PATCHES=(
	"${FILESDIR}/${PN}-9.7.patch"
)

src_unpack() {
	if [[ ${PV} == 9999 ]]; then
		git-r3_src_unpack
		sage-git_src_unpack "${PN}_pypi"
	fi

	default
}

python_prepare_all() {
	distutils-r1_python_prepare_all

	# sage on gentoo environment variables
	cp -f "${FILESDIR}"/${PN}.py-9.8 _sage_conf/_conf.py
	eprefixify _sage_conf/_conf.py
	# set the documentation location to the externally provided sage-doc package
	sed -i "s:@GENTOO_PORTAGE_PF@:sage-doc-${PV}:" _sage_conf/_conf.py
	# set lib/lib64 - only useful for GAP_LIB_DIR for now
	sed -i "s:@libdir@:$(get_libdir):g" _sage_conf/_conf.py
	# Fix finding pplpy documentation with intersphinx
	local pplpyver=$(best_version dev-python/pplpy)
	# using pplpyver from character 11 to remove "dev-python/"
	sed -i "s:@PPLY_DOC_VERS@:${pplpyver:11}:" _sage_conf/_conf.py
}
