APP      := RPNCALC
DEVICE   := fenix5s
OUT      := $(APP).PRG
TESTOUT  := $(APP)_TEST.PRG
KEY      := developer_key.der
SDKPATH  := ~/.Garmin/ConnectIQ/Sdks/connectiq-sdk-lin-9.2.0-2026-06-09-92a1605b2/bin

MONKEYC  := $(SDKPATH)/monkeyc
SIM      := $(SDKPATH)/simhack

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

clean:
	rm -f $(OUT) $(TESTOUT)

.PHONY: all run clean
