--- sage/env.py.orig	2014-02-16 23:08:04.416327616 +1300
+++ sage/env.py	2014-02-16 23:13:54.146017968 +1300
@@ -85,23 +85,20 @@
 _add_variable_or_fallback('LOCAL_IDENTIFIER','$HOSTNAME.%s'%os.getpid())
 
 # bunch of sage directories and files
-_add_variable_or_fallback('SAGE_ROOT',       None)
-_add_variable_or_fallback('SAGE_LOCAL',      opj('$SAGE_ROOT', 'local'))
-_add_variable_or_fallback('SAGE_ETC',        opj('$SAGE_LOCAL', 'etc'))
-_add_variable_or_fallback('SAGE_SHARE',      opj('$SAGE_LOCAL', 'share'))
+_add_variable_or_fallback('SAGE_ROOT',       opj('@GENTOO_PORTAGE_EPREFIX@/usr', 'share', 'sage'))
+_add_variable_or_fallback('SAGE_LOCAL',      opj('@GENTOO_PORTAGE_EPREFIX@/usr'))
+_add_variable_or_fallback('SAGE_ETC',        opj('@GENTOO_PORTAGE_EPREFIX@/etc'))
+_add_variable_or_fallback('SAGE_SHARE',      opj('$SAGE_LOCAL', 'share', 'sage'))
 
 # SAGE_LIB is the site-packages directory if the sage library
 # has been installed, otherwise it is the same of SAGE_SRC
 _add_variable_or_fallback('SAGE_SRC',        opj('$SAGE_ROOT', 'src'))
 _add_variable_or_fallback('SAGE_LIB',        os.path.dirname(os.path.dirname(__file__)))
 
-_add_variable_or_fallback('SAGE_EXTCODE',    opj('$SAGE_SHARE', 'sage', 'ext'))
-_add_variable_or_fallback('SAGE_LOGS',       opj('$SAGE_ROOT', 'logs', 'pkgs'))
-_add_variable_or_fallback('SAGE_SPKG_INST',  opj('$SAGE_LOCAL', 'var', 'lib', 'sage', 'installed'))
-_add_variable_or_fallback('SAGE_DOC',        opj('$SAGE_SRC', 'doc'))
-_add_variable_or_fallback('DOT_SAGE',        opj(os.environ.get('HOME','$SAGE_ROOT'), '.sage'))
+_add_variable_or_fallback('SAGE_EXTCODE',    opj('$SAGE_SHARE', 'ext'))
+_add_variable_or_fallback('SAGE_DOC',        opj('$SAGE_SHARE', 'doc'))
+_add_variable_or_fallback('DOT_SAGE',        opj(os.environ.get('HOME'), '.sage'))
 _add_variable_or_fallback('PYTHON_EGG_CACHE',opj('$DOT_SAGE','.python-eggs'))
-_add_variable_or_fallback('SAGE_DOT_GIT',    opj('$SAGE_ROOT', '.git'))
 
 # misc
 _add_variable_or_fallback('SAGE_URL',                'http://sage.math.washington.edu/sage/')
