# FLOW MAKEFILE
# not parsed by boilermake, but included
# as such, doesn't use boilermake functions

# git hash string transformed into a define in a generated header file to be included by sources
# -DIRTY or -CLEAN is appended depending on git status cmd output
.PHONY: target/gitHash.h
target/gitHash.h:
	@echo "# making $@"
	@mkdir -p $(dir $@)
	$(AT)tmpRev=target/gitHash.tmp                                ;\
	echo "#pragma once"                               > $$tmpRev &&\
	echo -n '#define GIT_HASH_STR "'                 >> $$tmpRev &&\
	/usr/bin/git log --pretty=format:'%h' -n 1                     \
			| tr --delete '\n'                       >> $$tmpRev  ;\
	set +e                                                        ;\
	/usr/bin/git diff-index --quiet HEAD                          ;\
	diffs=$$?                                                     ;\
	set -e                                                        ;\
	if [ "$$diffs" != "0" ]; then                                  \
	    echo -n '-DIRTY'                             >> $$tmpRev  ;\
	else                                                           \
	    echo -n '-CLEAN'                             >> $$tmpRev  ;\
	fi                                                           &&\
	echo '"'                                         >> $$tmpRev &&\
	echo ''                                          >> $$tmpRev &&\
	echo '#define GIT_HASH_LEN STRLEN(GIT_HASH_STR)' >> $$tmpRev &&\
	if [ ! -f $@ ]; then                                           \
	    new=1                                                     ;\
	else                                                           \
		set +e                                                    ;\
		diff $$tmpRev $@ 1>/dev/null                              ;\
		new=$$?                                                   ;\
		set -e                                                    ;\
	fi                                                           &&\
	if [ "$$new" != "0" ]; then                                    \
	    cp $$tmpRev $@                                            ;\
	fi

