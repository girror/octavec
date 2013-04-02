include $(top_srcdir)/Makefile.xt
include $(top_srcdir)/Makefile.octave

HL="----------------------------------------------------------"
ITS=5000


TESTS_M_M = \
  constant_initialization.m \
  constant_initialization_ans.m \
  for_test.m \
  if_test.m \
  multiple_assignment.m \
  structs.m \
  subscript.m \
  cat_matrix.m \
  cellindex.m

EXTRA_DIST = $(wildcard *.m)

CLEANFILES= \
  $(wildcard *_plain.m) \
  $(wildcard *_wrapper.m) \
  $(wildcard *_opt.m) \
  $(wildcard *.opt) \
  $(wildcard *.bin) 

OC=$(prefix)/bin/octavec 
OPTS=superopt

all-check : ${TESTS_M}
	@for file in ${TESTS_M}; do \
	  echo ${HL} $${file} ${HL} ; \
	  $(MAKE) "$${file%.m}_wrapper.m" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper_plain.m" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper_plain.timed-run" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper_opt.m" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper_opt.timed-run" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper.bin" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper.bin.timed-run2" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper.opt" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper.opt.timed-run2" || exit 1; \
	done

o2o-check : ${TESTS_M}
	@for file in ${TESTS_M}; do \
	  echo ${HL} $${file} ${HL} ; \
	  $(MAKE) "$${file%.m}_wrapper.m" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper_plain.m" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper_plain.timed-run" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper_opt.m" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper_opt.timed-run" || exit 1; \
	done

o2c-check : ${TESTS_M}
	@for file in ${TESTS_M}; do \
	  echo ${HL} $${file} ${HL} ; \
	  $(MAKE) "$${file%.m}_wrapper.bin" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper.bin.timed-run2" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper.opt" || exit 1; \
	  $(MAKE) "$${file%.m}_wrapper.opt.timed-run2" || exit 1; \
	done

%_plain.m: %.m
	@${OC} --o2o $@ -i `basename $< .m` --script

%_opt.m: %.m
	@${OC} --o2o $@ -i `basename $< .m` --opts ${OPTS} --script

%.bin : %.m
	@${OC} -i `basename $< .m` --script --keep 3 && mv `basename $< .m` $@  

%.opt : %.m
	@${OC} -i `basename $< .m` --script --keep 3 --opts ${OPTS} && mv `basename $< .m` $@ 

%.tc : %.m
	@${OC} -i `basename $< .m` --script --keep 3 --tc && mv `basename $< .m` $@ 


%_wrapper.m: %.m
	@( \
	echo "for x = 1:${ITS}" && \
	echo '  if(! ' `basename $< .m` '() )' && \
	echo '    quit(1);' && \
	echo '  end' && \
	echo 'end' \
	) > $@;
	
%.run: %.m
	@echo ${HL}
	@echo "Executing" $<
	@octave -q $< && echo $< 'passed!'  || (echo $< 'failed!' ; exit 1)
	@echo ""
	@echo ${HL} 

%.timed-run : %.m
	@echo ${HL}
	@echo "Executing" $<
	@time octave -q $< && echo $< 'passed!' || ( echo $< 'failed' ; exit 1)
	@echo ""
	@echo ${HL}

%.run2: % 
	@echo ${HL}
	@echo "Executing" $<
	@./$< && echo $< 'passed!'  || (echo $< 'failed!' ; exit 1)
	@echo ""
	@echo ${HL} 

%.timed-run2: % 
	@echo ${HL}
	@echo "Executing" $<
	@./$< && echo $< 'passed!'  || (echo $< 'failed!' ; exit 1)
	@echo ""
	@echo ${HL} 

