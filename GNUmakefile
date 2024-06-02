APP = myTunes
CFLAGS ?= -Wall
FRAMEWORKS = -framework AppKit -framework Cocoa

$(APP).app: $(APP).app/Contents/Info.plist $(APP).app/Contents $(APP).app/Contents/MacOS/$(APP)

%.o: %.m
	$(CC) $(CFLAGS) -c -x objective-c $< -o $@

%.app/Contents:
	mkdir -p "$@/"{Resources,MacOS}

%.app/Contents/Info.plist: Info.plist %.app/Contents
	cp -v $< $@

$(APP).app/Contents/MacOS/$(APP): main.o AppDelegate.o Library.o
	$(CC) $(CFLAGS) $(FRAMEWORKS) $? -o $@

clean:
	rm -vf $(APP) *.o
	rm -rf $(APP).app

.PHONY: clean
