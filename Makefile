NSC	= nsc
NSFLAGS	= -q -e -q -o -a -v1.70 -i ../ALFA-Base-Resources/alfa2_acr.hak/:../include/ -x " ERROR "
# flags:
# [-g:nodebug]
# [-v:version]
# [-i:include]
# [-a:analyze]
# [-o:optimize]

RM	= rm -f

OBJS	= $(patsubst %.nss,%.ncs,$(patsubst %.NSS,%.ncs,$(wildcard *.nss)))

.IGNORE:
.SILENT:
.SUFFIXES: .nss .ncs

all:	$(OBJS)
	echo Finished.

.nss.ncs:
	echo Compiling $<
	$(NSC) $(NSFLAGS) -c $<

clean:
	$(RM) *.ncs *.NCS
	$(RM) *.ndb *.NDB
