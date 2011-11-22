NSC	= nsc
NSFLAGS	= -x " error " -q -e -v1.69 -i ../include/:../ALFA-Base-Resources/alfa2_acr.hak/

RM	= rm -f

OBJS	= $(patsubst %.nss,%.ncs,$(wildcard *.nss))

.IGNORE:
.SILENT:
.SUFFIXES: .nss .ncs

all:	$(OBJS)
	echo $(OBJS)

.nss.ncs:
	echo Compiling $<
	$(NSC) $(NSFLAGS) -c $<

clean:
	$(RM) *.ncs *.NCS
	$(RM) *.ndb *.NDB
