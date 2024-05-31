APP = myTunes
CFLAGS ?= -Wall
FRAMEWORKS = -framework AppKit -framework Cocoa

$(APP).app: $(APP).app/Contents $(APP).app/Contents/MacOS/$(APP)

catalog:
	./build.pl

var/out/minivx:
	./build.pl -i minivx

minivx: var/out/minivx

%.o: %.m
	$(CC) $(CFLAGS) -c -x objective-c $< -o $@

%.app/Contents:
	mkdir -p "$@/"{Resources,MacOS}

%.app/Contents/Info.plist: minivx %.app/Contents
	PATH="$(PATH):var/out" minivx -Ze 'dup2(rewrite argv[1], fd 1); run argv[2..3]' \
		"$@" modules/metamage_1/bin/make-info-plist Info.txt

$(APP).app/Contents/MacOS/$(APP): main.o AppDelegate.o
	$(CC) $(CFLAGS) $(FRAMEWORKS) $? -o $@

clean:
	rm -vf $(APP) *.o
	rm -rf *.app
	rm -rf var/{out,build,cache}

.PHONY: clean catalog minivx
