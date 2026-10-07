lib_LTLIBRARIES = libpwmcp.la
libpwmcp_la_SOURCES=src/pwmcp.ads
obj_DIRS=obj
LIBS=
EXTRA_DIST = pwauth.gpr test/tests.gpr tests/*.ad* src/*
all-local:
	gprbuild -d -Ppwmcp.gpr -XLIBRARY_TYPE=relocatable -XAWS_BUILD=relocatable
	gprbuild -d -Ptest/tests.gpr -XLIBRARY_TYPE=relocatable -XAWS_BUILD=relocatable

check-local: all-local
	./tests/obj/test_driver

format:
	find . -type f -name '*.ad*'  -print0 |xargs -0 gnatpp --max-line-length=120 --split-line-before-op -l2

clean-local:
	rm -rf ${obj_DIRS}/*
	rm -rf lib/*
	rm -rf tests/obj/*
	rm -rf *.o
	rm -rf *.ali
	rm -rf *.so
	rm -rf configure~
	rm -rf autom4te.cache/*
	rm -rf autom4te.cache
	rm -f =*~
