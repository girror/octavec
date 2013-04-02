function addLocal(lp)
filesep = '/';
if(strcmp(lp,'empty') == 1)
  ap = [pwd,filesep];
else
  ap = [pwd,filesep,lp];
endif
addpath(ap);
%fprintf('  ''%s'' added to path.\n', ap);
printf("  '%s' added to path.\n", ap);   %Octave uses a different notation
