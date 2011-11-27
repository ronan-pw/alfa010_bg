NSC	= nsc
NSFLAGS	= -q -e -g -a -v1.69 -i ../include/:../ALFA-Base-Resources/alfa2_acr.hak/ -x " ERROR "

RM	= rm -f

OBJS	= $(patsubst %.nss,%.ncs,$(wildcard *.nss))

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
