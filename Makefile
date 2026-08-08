APP      := RPNCALC
DEVICE   := fenix5s
OUT      := $(APP).PRG
TESTOUT  := $(APP)_TEST.PRG
PKG      := $(APP).iq
KEY      := developer_key.der

ifeq ($(shell command -v monkeyc 2>/dev/null),)
	PREFIX  := ~/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-9.2.0-2026-06-09-92a1605b2/bin/
endif

MONKEYC  := $(PREFIX)monkeyc
SIM      := $(PREFIX)simhack

all: $(OUT)

$(OUT): $(wildcard source/*.mc) monkey.jungle manifest.xml
	$(MONKEYC) \
		-f monkey.jungle \
		-o $(OUT) \
		-y $(KEY) \
		-d $(DEVICE)

$(TESTOUT): $(wildcard source/*.mc) $(wildcard tests/*.mc) monkey.jungle manifest.xml
	$(MONKEYC) \
		--typecheck 2\
		-f monkey.jungle \
		-o $(TESTOUT) \
		-y $(KEY) \
		-d $(DEVICE) \
		-t

run: $(OUT)
	$(SIM) $(OUT) $(DEVICE)

test: $(TESTOUT)
	$(SIM) $(TESTOUT) $(DEVICE) -t

package:
	$(MONKEYC) \
		-f monkey.jungle \
		-o $(PKG) \
		-y $(KEY) \
    -e

clean:
	rm -f $(OUT) $(TESTOUT) $(PKG)

.PHONY: all run clean
