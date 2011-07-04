
GPRBUILD=gprbuild
GPRCLEAN=gprclean

all: pre
	$(GPRBUILD) -P tinywm.gpr

clean: pre
	$(GPRCLEAN) tinywm.gpr
	rm -rf build

pre:
	mkdir -p obj/debug obj/release
