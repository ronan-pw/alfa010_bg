NSC	= nsc
NSFLAGS	= -q -e -q -o -a -v1.70 -i ../ALFA-Base-Resources/alfa2_acr.hak/:../include/ -x " ERROR "
# flags:
# [-g:nodebug]
# [-v:version]
# [-i:include]
# [-a:analyze]
# [-o:optimize]

RM	= rm -f

INCS	= 010_area_ex \
	  010_cloned_area \
	  010_door_i \
	  010_drugs_i \
	  010_location_i \
	  010_namegen_i \
	  010_randomnpc_i \
	  010_spawn_ex \
	  010_swim_i \
	  010_twalker_i \
	  010_uda6_puzzle_inc \
	  010_weather_i	\
	  1sc_searchable \
	  1sc_searchable_treasure \
	  acf_settings_i \
	  acf_spawn_i \
	  acr_creature_i \
	  acr_vanity_i \
	  acr_wildmagic_i \
	  as_group_i \
	  ayergo_cre_i \
	  dpss_include \
	  npc_onhb \
	  npc_onper \
	  nwnx_nwscriptvm_include \
	  test_var_i \
	  tw_secret
	  
	  

FILES	= $(patsubst %.nss,%.ncs,$(patsubst %.NSS,%.ncs,$(wildcard *.nss)))
F_INCS	= $(patsubst %,%.ncs,$(INCS))

OBJS	= $(filter-out $(F_INCS),$(FILES))


.IGNORE:
.SUFFIXES: .nss .ncs

all:	$(OBJS)

.nss.ncs:
	$(NSC) $(NSFLAGS) -c $<

clean:
	$(RM) *.ncs *.NCS
	$(RM) *.ndb *.NDB
