SWIPLSRC=/home/nha/code/swipl
CHEZSRC=/home/nha/code/ChezScheme
SHENSRC=/home/nha/code/shen-scheme-prolog
UID=$(shell id -u)
GID=$(shell id -g)
IMG=swipl-mingw-f35
IT=-it

MOUNT=	  -v $(SWIPLSRC):/home/swipl/src/swipl-devel -v $(CHEZSRC):/home/ChezScheme -v $(SHENSRC):/home/shen
MOUNTX11= -v /tmp/.X11-unix:/tmp/.X11-unix

all::
	@echo "Targets:"
	@echo
	@echo "  image     Build the docker image"
	@echo "  run       Run a shell for building SWI-Prolog"
	@echo "  runx11    As 'run', providing X11 graphics"
	@echo "  win32     Build and package 32-bit version"
	@echo "  win64     Build and package 64-bit version"
	@echo "  win       Build and package both 32-bit and 64-bit version"
	@echo

BUILDARGS=--build-arg UID=$(UID) --build-arg GID=$(GID)

image:	Dockerfile
	docker build $(BUILDARGS) -t $(IMG) . 2>&1 | tee mkimg.log

run:
	docker run $(IT) --rm $(MOUNT) $(IMG)

run11:
	docker run $(IT) --rm $(MOUNT) $(MOUNTX11) -e DISPLAY=${DISPLAY} $(IMG)

win32:
	docker run $(IT) --rm $(MOUNT) $(IMG) --win32

win64:
	docker run $(IT) --rm $(MOUNT) $(IMG) --win64

win:
	docker run $(IT) --rm $(MOUNT) $(IMG) --win32 x--win64
