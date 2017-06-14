# A simple makefile for creating the MEA steady state model distribution tarball
VERSION    := $(shell git describe --tags --dirty)
PRODUCT    := MEA Steady State Model
PROD_SNAME := MEA_ssm
LICENSE    := LICENSE.md
PKG_DIR    := CCSI_$(PROD_SNAME)_$(VERSION)
PACKAGE    := $(PKG_DIR).tgz

# TODO: add fortram files for dll to Payload
PAYLOAD := README.md \
	*.bkp \
        *.opt \
        $(LICENSE)

# Get just the top part (not dirname) of each entry so cp -r does the right thing
PAYLOAD_TOPS := $(foreach v,$(PAYLOAD),$(shell echo $v | cut -d'/' -f1))
# And the payload with the PKG_DIR prepended
PKG_PAYLOAD := $(addprefix $(PKG_DIR)/, $(PAYLOAD))

# OS detection & changes
UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
  MD5BIN=md5sum
endif
ifeq ($(UNAME), Darwin)
  MD5BIN=md5
endif
ifeq ($(UNAME), FreeBSD)
  MD5BIN=md5
endif

.PHONY: all clean

all: $(PACKAGE)

# Make compressed tar file without timestamp (gzip -n) so md5sum
# doesn't change if the payload hasn't
$(PACKAGE): $(PAYLOAD)
	@mkdir $(PKG_DIR)
	@cp -r $(PAYLOAD_TOPS) $(PKG_DIR)
	@tar -cf - $(PKG_PAYLOAD) | gzip -n > $(PACKAGE)
	@$(MD5BIN) $(PACKAGE)
	@rm -rf $(PKG_DIR)

clean:
	@rm -rf $(PACKAGE) $(PKG_DIR) *.tgz
