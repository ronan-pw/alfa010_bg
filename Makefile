NSC	= nsc
NSFLAGS	= -q -e -o -a -v1.69 -i ../include/:../ALFA-Base-Resources/alfa2_acr.hak/ -x " ERROR "
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
