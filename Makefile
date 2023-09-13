CPP = g++
BUILDDIR = ./build

COMPILEFLAGS = -c -wall -werror
LINKFLAGS = -lm

.PHONY = all clean update_pages

all: pack_pages tldr

pack_pages: pack_pages.o
	./{BUILDDIR}/pack_pages

tldr: tldr.o
	${cpp}

%.o: %.cpp
	${CPP} ${COMPILEFLAGS} $< ${BUILDDIR}/$@

%: %.o
	${CPP} ${LINKFLAGS} ${BUILDDIR}/$< -o ${BUILDDIR}/$@

update_pages:
	rm -rf pages
	mkdir clone
	git clone --depth 1 -b main --single-branch https://github.com/tldr-pages/tldr.git clone
	mkdir pages
	mv clone/tldr/pages/* pages
	rm -rf clone

$(BUILDDIR):
	mkdir $(BUILDDIR)


clean:
	rm -rf build
